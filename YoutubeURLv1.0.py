# ------------------------------------------------------------
# YoutubeURL v1.0
# Creado por David Hidalgo Marsal (dhm@hotmail.es)
# Web de proyectos: https://dhmar91.github.io/
# Fecha: 25/03/2026
#
# Aplicación para descargar vídeos y audio de YouTube
# con soporte para múltiples formatos, calidad máxima,
# miniatura, historial, progreso detallado y FFmpeg local.
# ------------------------------------------------------------

import os
import io
import urllib.request
import webbrowser

import yt_dlp
import customtkinter as ctk
from tkinter import filedialog, messagebox
from PIL import Image, ImageTk

# -----------------------------
# CONFIGURACIÓN GLOBAL
# -----------------------------
ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
FFMPEG_LOCATION = os.path.join(BASE_DIR, "ffmpeg")
SETTINGS_FILE = os.path.join(BASE_DIR, "settings.txt")

FORMATOS_SALIDA = [
    "Original", "MP4", "MKV", "WEBM",
    "MP3", "WAV", "AAC", "OGG", "FLAC"
]

VIDEO_CALIDADES_MAX = [
    ("Original", None),
    ("2160p (4K)", 2160),
    ("1440p (2K)", 1440),
    ("1080p", 1080),
    ("720p", 720),
    ("480p", 480),
    ("360p", 360),
]

MP3_BITRATES_MAX = [
    ("Original", None),
    ("320 kbps", 320),
    ("256 kbps", 256),
    ("192 kbps", 192),
    ("128 kbps", 128),
    ("96 kbps", 96),
]


# -----------------------------
# FUNCIONES AUXILIARES
# -----------------------------
def segundos_a_hms(seg):
    if seg is None:
        return "Desconocido"
    seg = int(seg)
    h = seg // 3600
    m = (seg % 3600) // 60
    s = seg % 60
    return f"{h:02d}:{m:02d}:{s:02d}" if h > 0 else f"{m:02d}:{s:02d}"


def cargar_miniatura(url):
    try:
        with urllib.request.urlopen(url) as resp:
            data = resp.read()
        img = Image.open(io.BytesIO(data))
        img.thumbnail((260, 260))
        return ImageTk.PhotoImage(img)
    except Exception:
        return None


def formatear_tamano(bytes_val):
    if bytes_val is None:
        return "Desconocido"
    unidades = ["B", "KB", "MB", "GB", "TB"]
    i = 0
    f = float(bytes_val)
    while f >= 1024 and i < len(unidades) - 1:
        f /= 1024.0
        i += 1
    return f"{f:.2f} {unidades[i]}"


def cargar_carpeta_guardada():
    if os.path.exists(SETTINGS_FILE):
        try:
            with open(SETTINGS_FILE, "r", encoding="utf-8") as f:
                ruta = f.read().strip()
            if ruta and os.path.isdir(ruta):
                return ruta
        except:
            pass
    return BASE_DIR


def guardar_carpeta(ruta):
    try:
        with open(SETTINGS_FILE, "w", encoding="utf-8") as f:
            f.write(ruta)
    except:
        pass


# -----------------------------
# ITEM HISTORIAL
# -----------------------------
class DownloadItem(ctk.CTkFrame):
    def __init__(self, master, titulo, formato, carpeta_destino, *args, **kwargs):
        super().__init__(master, *args, **kwargs)

        self.titulo = titulo
        self.formato = formato
        self.carpeta_destino = carpeta_destino
        self.archivo_salida = None

        self.grid_columnconfigure(0, weight=1)

        self.label_titulo = ctk.CTkLabel(self, text=f"{titulo} [{formato}]", anchor="w")
        self.label_titulo.grid(row=0, column=0, sticky="ew", padx=5, pady=(5, 0))

        self.progress = ctk.CTkProgressBar(self)
        self.progress.set(0)
        self.progress.grid(row=1, column=0, sticky="ew", padx=5)

        self.label_estado = ctk.CTkLabel(self, text="Esperando…", anchor="w")
        self.label_estado.grid(row=2, column=0, sticky="ew", padx=5, pady=(2, 5))

        self.btn_abrir = ctk.CTkButton(self, text="Abrir carpeta", width=120,
                                       command=self.abrir_carpeta)
        self.btn_abrir.grid(row=0, column=1, rowspan=3, padx=5, pady=5)

    def actualizar_progreso(self, p, vel, eta, descargado, total, estado):
        self.progress.set(p / 100.0)
        self.label_estado.configure(
            text=f"{p:.1f}% — {estado}\n{descargado} / {total} — {vel} — ETA {eta}"
        )

    def marcar_completado(self, archivo):
        self.archivo_salida = archivo
        self.progress.set(1.0)
        self.label_estado.configure(text="100% — Completado")

    def marcar_error(self, msg):
        self.label_estado.configure(text=f"Error: {msg}")

    def abrir_carpeta(self):
        carpeta = os.path.dirname(self.archivo_salida) if self.archivo_salida else self.carpeta_destino
        if os.name == "nt":
            os.startfile(carpeta)
        else:
            webbrowser.open(f"file://{carpeta}")


# -----------------------------
# APLICACIÓN PRINCIPAL
# -----------------------------
class YouTubeDownloaderApp(ctk.CTk):

    def __init__(self):
        super().__init__()

        self.title("YoutubeURL v1.0")
        self.geometry("1000x600")
        self.minsize(900, 550)

        self.carpeta_destino = cargar_carpeta_guardada()
        self.info_video_actual = None
        self.thumbnail_image = None
        self.current_item = None

        self.crear_ui()

    # -------------------------
    # UI
    # -------------------------
    def crear_ui(self):
        self.grid_columnconfigure(0, weight=2)
        self.grid_columnconfigure(1, weight=3)

        # Panel izquierdo
        self.frame_left = ctk.CTkFrame(self)
        self.frame_left.grid(row=0, column=0, sticky="nsew", padx=10, pady=10)
        self.frame_left.grid_columnconfigure(0, weight=1)

        # Panel derecho
        self.frame_right = ctk.CTkFrame(self)
        self.frame_right.grid(row=0, column=1, sticky="nsew", padx=10, pady=10)
        self.frame_right.grid_columnconfigure(0, weight=1)
        self.frame_right.grid_rowconfigure(3, weight=1)
        self.frame_right.grid_rowconfigure(5, weight=1)

        # Cabecera
        self.label_titulo = ctk.CTkLabel(
            self.frame_left,
            text="YoutubeURL 1.0",
            font=ctk.CTkFont(size=22, weight="bold"),
            text_color="#4da6ff"
        )
        self.label_titulo.grid(row=0, column=0, sticky="w", padx=10, pady=(10, 0))

        self.label_autor_top = ctk.CTkLabel(
            self.frame_left,
            text="Creado por David Hidalgo Marsal - DHM@hotmail.es - https://dhmar91.github.io",
            font=ctk.CTkFont(size=12),
            text_color="#4da6ff"
        )
        self.label_autor_top.grid(row=1, column=0, sticky="w", padx=10, pady=(0, 10))

        # Tema
        self.label_tema = ctk.CTkLabel(self.frame_left, text="Tema")
        self.label_tema.grid(row=2, column=0, sticky="w", padx=10)

        self.combo_tema = ctk.CTkComboBox(
            self.frame_left, values=["Oscuro", "Claro"],
            state="readonly", command=self.cambiar_tema
        )
        self.combo_tema.set("Oscuro")
        self.combo_tema.grid(row=3, column=0, sticky="ew", padx=10, pady=(0, 10))

        # URL
        self.label_url = ctk.CTkLabel(self.frame_left, text="URL de YouTube")
        self.label_url.grid(row=4, column=0, sticky="w", padx=10)

        self.entry_url = ctk.CTkEntry(self.frame_left, placeholder_text="Pega aquí la URL")
        self.entry_url.grid(row=5, column=0, sticky="ew", padx=10, pady=(0, 10))
        self.entry_url.bind("<KeyRelease>", self.evento_url_cambiada)

        # Carpeta destino
        self.label_carpeta = ctk.CTkLabel(self.frame_left, text="Carpeta destino")
        self.label_carpeta.grid(row=6, column=0, sticky="w", padx=10)

        self.frame_carpeta = ctk.CTkFrame(self.frame_left)
        self.frame_carpeta.grid(row=7, column=0, sticky="ew", padx=10, pady=(0, 10))
        self.frame_carpeta.grid_columnconfigure(0, weight=1)

        self.entry_carpeta = ctk.CTkEntry(self.frame_carpeta)
        self.entry_carpeta.grid(row=0, column=0, sticky="ew", padx=(0, 5))
        self.entry_carpeta.insert(0, self.carpeta_destino)

        self.btn_carpeta = ctk.CTkButton(self.frame_carpeta, text="Elegir", width=80,
                                         command=self.elegir_carpeta)
        self.btn_carpeta.grid(row=0, column=1)

        # Formato
        self.label_formato = ctk.CTkLabel(self.frame_left, text="Formato de salida")
        self.label_formato.grid(row=8, column=0, sticky="w", padx=10)

        self.combo_formato = ctk.CTkComboBox(
            self.frame_left, values=FORMATOS_SALIDA, state="readonly"
        )
        self.combo_formato.set("Original")
        self.combo_formato.grid(row=9, column=0, sticky="ew", padx=10, pady=(0, 10))

        # Calidad vídeo
        self.label_video_quality = ctk.CTkLabel(self.frame_left, text="Calidad de vídeo (máxima)")
        self.label_video_quality.grid(row=10, column=0, sticky="w", padx=10)

        self.combo_video_quality = ctk.CTkComboBox(
            self.frame_left, values=[v[0] for v in VIDEO_CALIDADES_MAX], state="readonly"
        )
        self.combo_video_quality.set("Original")
        self.combo_video_quality.grid(row=11, column=0, sticky="ew", padx=10, pady=(0, 10))

        # Bitrate MP3
        self.label_mp3_bitrate = ctk.CTkLabel(self.frame_left, text="Bitrate MP3 (máximo)")
        self.label_mp3_bitrate.grid(row=12, column=0, sticky="w", padx=10)

        self.combo_mp3_bitrate = ctk.CTkComboBox(
            self.frame_left, values=[b[0] for b in MP3_BITRATES_MAX], state="readonly"
        )
        self.combo_mp3_bitrate.set("Original")
        self.combo_mp3_bitrate.grid(row=13, column=0, sticky="ew", padx=10, pady=(0, 10))

        # Progreso
        self.progress_global = ctk.CTkProgressBar(self.frame_left)
        self.progress_global.set(0)
        self.progress_global.grid(row=14, column=0, sticky="ew", padx=10)

        self.label_progreso_global = ctk.CTkLabel(self.frame_left, text="0%")
        self.label_progreso_global.grid(row=15, column=0, sticky="e", padx=10, pady=(0, 10))

        # Botón descargar
        self.btn_descargar = ctk.CTkButton(self.frame_left, text="Descargar",
                                           command=self.descargar)
        self.btn_descargar.grid(row=16, column=0, sticky="ew", padx=10, pady=(5, 10))
        # Panel derecho
        self.label_miniatura = ctk.CTkLabel(self.frame_right, text="Miniatura")
        self.label_miniatura.grid(row=0, column=0, sticky="w", padx=10, pady=(10, 0))

        self.canvas_miniatura = ctk.CTkLabel(self.frame_right, text="")
        self.canvas_miniatura.grid(row=1, column=0, pady=(0, 10))

        self.label_info = ctk.CTkLabel(self.frame_right, text="Información del vídeo")
        self.label_info.grid(row=2, column=0, sticky="w", padx=10)

        self.text_info = ctk.CTkTextbox(self.frame_right, height=120)
        self.text_info.grid(row=3, column=0, sticky="nsew", padx=10, pady=(0, 10))
        self.text_info.configure(state="disabled")

        self.label_historial = ctk.CTkLabel(self.frame_right, text="Historial de descargas")
        self.label_historial.grid(row=4, column=0, sticky="w", padx=10)

        self.scroll_historial = ctk.CTkScrollableFrame(self.frame_right)
        self.scroll_historial.grid(row=5, column=0, sticky="nsew", padx=10, pady=(0, 10))
        self.scroll_historial.grid_columnconfigure(0, weight=1)

    # -------------------------
    # TEMA
    # -------------------------
    def cambiar_tema(self, valor):
        ctk.set_appearance_mode("light" if valor == "Claro" else "dark")

    # -------------------------
    # EVENTO URL
    # -------------------------
    def evento_url_cambiada(self, event=None):
        url = self.entry_url.get().strip()
        if url.startswith("http"):
            self.cargar_info_video()

    # -------------------------
    # CARPETA
    # -------------------------
    def elegir_carpeta(self):
        carpeta = filedialog.askdirectory()
        if carpeta:
            self.carpeta_destino = carpeta
            self.entry_carpeta.delete(0, "end")
            self.entry_carpeta.insert(0, carpeta)
            guardar_carpeta(carpeta)

    # -------------------------
    # PROGRESO
    # -------------------------
    def hook_progreso(self, d):
        if not self.current_item:
            return

        status = d.get("status")

        if status == "downloading":
            p = float(d.get("_percent_str", "0%").replace("%", "").strip() or 0)
            vel = d.get("_speed_str", "N/A")
            eta = d.get("_eta_str", "N/A")

            total = formatear_tamano(d.get("total_bytes") or d.get("total_bytes_estimate"))
            descargado = formatear_tamano(d.get("downloaded_bytes"))

            self.progress_global.set(p / 100.0)
            self.label_progreso_global.configure(text=f"{p:.1f}%")

            self.current_item.actualizar_progreso(
                p, vel, eta, descargado, total, "Descargando…"
            )

        elif status == "finished":
            self.current_item.actualizar_progreso(
                100, "N/A", "0s", "?", "?", "Convirtiendo…"
            )
            self.progress_global.set(1.0)
            self.label_progreso_global.configure(text="Procesando…")

    # -------------------------
    # INFO VÍDEO
    # -------------------------
    def cargar_info_video(self):
        url = self.entry_url.get().strip()
        if not url.startswith("http"):
            return

        try:
            opts = {"quiet": True, "skip_download": True, "ffmpeg_location": FFMPEG_LOCATION}
            with yt_dlp.YoutubeDL(opts) as ydl:
                info = ydl.extract_info(url, download=False)

            self.info_video_actual = info

            titulo = info.get("title", "Desconocido")
            duracion = segundos_a_hms(info.get("duration"))
            formatos = info.get("formats", [])

            alturas = sorted({f.get("height") for f in formatos if f.get("height")})
            max_altura = max(alturas) if alturas else None

            abr_list = sorted({int(f.get("abr") or f.get("tbr")) for f in formatos if f.get("abr") or f.get("tbr")})
            max_abr = max(abr_list) if abr_list else None

            thumb = info.get("thumbnail")
            if thumb:
                img = cargar_miniatura(thumb)
                if img:
                    self.thumbnail_image = img
                    self.canvas_miniatura.configure(image=img, text="")
                else:
                    self.canvas_miniatura.configure(text="Sin miniatura")
            else:
                self.canvas_miniatura.configure(text="Sin miniatura")

            # Info texto
            self.text_info.configure(state="normal")
            self.text_info.delete("1.0", "end")
            self.text_info.insert("end", f"Título: {titulo}\n")
            self.text_info.insert("end", f"Duración: {duracion}\n")
            if max_altura:
                self.text_info.insert("end", f"Resolución máxima: {max_altura}p\n")
            else:
                self.text_info.insert("end", "Resolución máxima: desconocida\n")
            if max_abr:
                self.text_info.insert("end", f"Bitrate audio máx.: {max_abr} kbps\n")
            else:
                self.text_info.insert("end", "Bitrate audio máx.: desconocido\n")
            self.text_info.configure(state="disabled")

            # Rellenar combos de calidad según lo disponible
            self.actualizar_combo_video_quality(max_altura)
            self.actualizar_combo_mp3_bitrate(max_abr)

        except Exception as e:
            messagebox.showerror("Error", f"No se pudo obtener la información del vídeo:\n{e}")

    def actualizar_combo_video_quality(self, max_altura):
        valores = []
        for texto, altura in VIDEO_CALIDADES_MAX:
            if altura is None:
                valores.append(texto)
            else:
                if max_altura is None or altura <= max_altura:
                    valores.append(texto)
        if not valores:
            valores = ["Original"]
        self.combo_video_quality.configure(values=valores)
        self.combo_video_quality.set("Original")

    def actualizar_combo_mp3_bitrate(self, max_abr):
        valores = []
        for texto, br in MP3_BITRATES_MAX:
            if br is None:
                valores.append(texto)
            else:
                if max_abr is None or br <= max_abr:
                    valores.append(texto)
        if not valores:
            valores = ["Original"]
        self.combo_mp3_bitrate.configure(values=valores)
        self.combo_mp3_bitrate.set("Original")

    # -------------------------
    # CONSTRUCCIÓN OPCIONES YDL
    # -------------------------
    def construir_ydl_opts(self, formato_salida):
        opts = {
            "outtmpl": os.path.join(self.carpeta_destino, "%(title)s.%(ext)s"),
            "progress_hooks": [self.hook_progreso],
            "ffmpeg_location": FFMPEG_LOCATION,
        }

        # Calidad de vídeo máxima elegida
        texto_video = self.combo_video_quality.get()
        altura_max = None
        for texto, h in VIDEO_CALIDADES_MAX:
            if texto == texto_video:
                altura_max = h
                break

        # Bitrate MP3 máximo elegido
        texto_mp3 = self.combo_mp3_bitrate.get()
        br_max = None
        for texto, br in MP3_BITRATES_MAX:
            if texto == texto_mp3:
                br_max = br
                break

        # Vídeo / contenedores
        if formato_salida in ["Original", "MP4", "MKV", "WEBM"]:
            if altura_max is None:
                video_fmt = "bestvideo+bestaudio/best"
            else:
                video_fmt = f"bestvideo[height<={altura_max}]+bestaudio/best"

            if formato_salida == "Original":
                opts["format"] = video_fmt
            else:
                contenedor = formato_salida.lower()
                opts["format"] = video_fmt
                opts["postprocessors"] = [{
                    "key": "FFmpegVideoConvertor",
                    "preferedformat": contenedor
                }]

        # Audio
        elif formato_salida in ["MP3", "WAV", "AAC", "OGG", "FLAC"]:
            codec = formato_salida.lower()
            opts["format"] = "bestaudio/best"

            post = {
                "key": "FFmpegExtractAudio",
                "preferredcodec": codec,
            }

            if formato_salida == "MP3":
                if br_max is not None:
                    post["preferredquality"] = str(br_max)
                else:
                    post["preferredquality"] = "192"

            opts["postprocessors"] = [post]

        return opts

    # -------------------------
    # DESCARGA
    # -------------------------
    def crear_item_historial(self, titulo, formato):
        item = DownloadItem(self.scroll_historial, titulo, formato, self.carpeta_destino)
        filas = len(self.scroll_historial.winfo_children())
        item.grid(row=filas, column=0, sticky="ew", padx=5, pady=5)

        # Auto-scroll al final
        self.scroll_historial.update_idletasks()
        try:
            self.scroll_historial._parent_canvas.yview_moveto(1.0)
        except Exception:
            pass

        return item

    def descargar(self):
        url = self.entry_url.get().strip()
        self.carpeta_destino = self.entry_carpeta.get().strip()
        guardar_carpeta(self.carpeta_destino)
        formato_salida = self.combo_formato.get()

        if not url:
            messagebox.showwarning("Aviso", "Introduce una URL.")
            return

        # Si no hay info cargada o la URL cambió → cargar info
        if self.info_video_actual is None or self.info_video_actual.get("webpage_url") != url:
            self.cargar_info_video()
            if self.info_video_actual is None:
                return

        if not self.carpeta_destino or not os.path.isdir(self.carpeta_destino):
            messagebox.showwarning("Aviso", "Selecciona una carpeta válida.")
            return

        # Comprobar ffmpeg
        ffmpeg_exe = os.path.join(FFMPEG_LOCATION, "ffmpeg.exe")
        ffprobe_exe = os.path.join(FFMPEG_LOCATION, "ffprobe.exe")
        if not (os.path.exists(ffmpeg_exe) and os.path.exists(ffprobe_exe)):
            messagebox.showerror(
                "FFmpeg no encontrado",
                f"No se ha encontrado ffmpeg.exe o ffprobe.exe en:\n{FFMPEG_LOCATION}"
            )
            return

        self.progress_global.set(0)
        self.label_progreso_global.configure(text="0%")
        self.update_idletasks()

        try:
            # Obtener info para título
            info_opts = {
                "quiet": True,
                "skip_download": True,
                "ffmpeg_location": FFMPEG_LOCATION,
            }
            with yt_dlp.YoutubeDL(info_opts) as ydl_info:
                info = ydl_info.extract_info(url, download=False)

            titulo = info.get("title", "Desconocido")

            # Crear item en historial
            self.current_item = self.crear_item_historial(titulo, formato_salida)

            # Opciones de descarga
            ydl_opts = self.construir_ydl_opts(formato_salida)

            # Descarga real
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                info_final = ydl.extract_info(url, download=True)
                nombre_archivo = ydl.prepare_filename(info_final)
                if "ext" in info_final:
                    base, _ = os.path.splitext(nombre_archivo)
                    nombre_archivo = base + "." + info_final["ext"]

            self.current_item.marcar_completado(nombre_archivo)
            self.label_progreso_global.configure(text="Completado")
            messagebox.showinfo("Éxito", "Descarga finalizada")

        except Exception as e:
            if self.current_item:
                self.current_item.marcar_error(str(e))
            messagebox.showerror("Error", f"Error durante la descarga:\n{e}")
        finally:
            self.current_item = None


# -----------------------------
# MAIN
# -----------------------------
if __name__ == "__main__":
    app = YouTubeDownloaderApp()
    app.mainloop()
