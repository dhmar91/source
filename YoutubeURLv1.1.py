# ------------------------------------------------------------
# YoutubeURL v1.1
# Creado por David Hidalgo Marsal (dhm@hotmail.es)
# Web de proyectos: https://dhmar91.github.io/
# Fecha: 25/03/2026
# Última actualización: 03/04/2026
#
# Aplicación para descargar vídeos y audio de YouTube
# con soporte para múltiples formatos, calidad máxima,
# miniatura, historial, progreso detallado y FFmpeg local.
# Soporta corte desde un segundo inicial si la URL contiene ?t= o &t=
# ------------------------------------------------------------

import os
import io
import re
import socket
import urllib.request
import webbrowser
import tkinter as tk
import threading
import time

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

# Expresión regular para validar URLs de YouTube
YOUTUBE_REGEX = re.compile(
    r'(https?://)?(www\.)?(youtube\.com|youtu\.be|m\.youtube\.com)/'
)

# Timeout global para conexiones (segundos)
socket.setdefaulttimeout(15)

# -----------------------------
# FUNCIONES AUXILIARES
# -----------------------------
def es_url_youtube(url):
    return bool(YOUTUBE_REGEX.match(url.strip()))

def segundos_a_hms(seg):
    if seg is None:
        return "Desconocido"
    seg = int(seg)
    h = seg // 3600
    m = (seg % 3600) // 60
    s = seg % 60
    return f"{h:02d}:{m:02d}:{s:02d}" if h > 0 else f"{m:02d}:{s:02d}"

def cargar_miniatura(url, timeout=10):
    try:
        with urllib.request.urlopen(url, timeout=timeout) as resp:
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

def parse_t_param(t_str):
    """
    Convierte un parámetro t de YouTube a segundos.
    Ejemplos: '20' -> 20, '1m20s' -> 80, '1:20' -> 80, '1h2m3s' -> 3723
    """
    if not t_str:
        return None
    t_str = t_str.strip().lower()
    # Si es solo número, asumimos segundos
    if t_str.isdigit():
        return int(t_str)
    # Patrón para h/m/s
    match = re.match(r'(?:(\d+)h)?(?:(\d+)m)?(?:(\d+)s?)?', t_str)
    if match:
        h = int(match.group(1)) if match.group(1) else 0
        m = int(match.group(2)) if match.group(2) else 0
        s = int(match.group(3)) if match.group(3) else 0
        return h*3600 + m*60 + s
    # Formato mm:ss o hh:mm:ss
    parts = t_str.split(':')
    if len(parts) == 2:
        return int(parts[0])*60 + int(parts[1])
    elif len(parts) == 3:
        return int(parts[0])*3600 + int(parts[1])*60 + int(parts[2])
    return None

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

        self.title("YoutubeURL v1.1")
        self.geometry("1000x600")
        self.minsize(900, 550)

        self.carpeta_destino = cargar_carpeta_guardada()
        self.info_video_actual = None
        self.thumbnail_image = None
        self.current_item = None
        self.cargando_info = False
        self.tiempo_inicio = None   # segundos desde donde cortar

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
            text="YoutubeURL 1.1",
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
        self.entry_url.bind("<Button-3>", self.mostrar_menu_contextual)
        self.entry_url.bind("<Control-v>", self.pegar_url)
        self.entry_url.bind("<Control-c>", self.copiar_url)

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
        if url.startswith("http") and not self.cargando_info and es_url_youtube(url):
            # Extraer parámetro t de la URL original (antes de limpiar)
            self.tiempo_inicio = self.extraer_t_param(url)
            self.cargar_info_video_thread()
        elif url.startswith("http") and not es_url_youtube(url):
            self.mostrar_error_info("La URL no pertenece a YouTube.\nPor favor, introduce una URL válida de YouTube.")

    def extraer_t_param(self, url):
        """Busca t= o start= en la URL y devuelve segundos."""
        # Patrones posibles: [?&]t=20, [?&]t=1m20s, [?&]start=20
        match = re.search(r'[?&](?:t|start)=([^&]+)', url)
        if match:
            t_val = match.group(1)
            return parse_t_param(t_val)
        return None

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
    # MENÚ CONTEXTUAL Y PORTAPAPELES
    # -------------------------
    def limpiar_url(self, url):
        """Elimina todo después del primer & (parámetros), pero conserva ?t si existe? Realmente queremos limpiar para la API,
        pero necesitamos el t antes. Por eso la extracción se hace antes. Esta función sigue usándose para pegar."""
        if '&' in url:
            url = url.split('&')[0]
        return url

    def pegar_url(self, event=None):
        try:
            texto = self.clipboard_get()
            # Extraer tiempo ANTES de limpiar
            t_seg = self.extraer_t_param(texto)
            if t_seg is not None:
                self.tiempo_inicio = t_seg
            texto_limpio = self.limpiar_url(texto)
            self.entry_url.delete(0, 'end')
            self.entry_url.insert(0, texto_limpio)
            self.evento_url_cambiada()
        except Exception:
            pass
        return "break"

    def copiar_url(self, event=None):
        url = self.entry_url.get()
        if url:
            self.clipboard_clear()
            self.clipboard_append(url)
        return "break"

    def mostrar_menu_contextual(self, event):
        menu = tk.Menu(self, tearoff=False)
        #menu.add_command(label="Copiar", command=self.copiar_url)
        #menu.add_separator()
        menu.add_command(label="Pegar", command=self.pegar_url)
        menu.post(event.x_root, event.y_root)

    # -------------------------
    # CARGA DE INFO EN HILO CON TIMEOUT
    # -------------------------
    def cargar_info_video_thread(self):
        if self.cargando_info:
            return
        self.cargando_info = True
        self.config(cursor="watch")
        self.btn_descargar.configure(state="disabled")
        threading.Thread(target=self.cargar_info_video, daemon=True).start()

    def cargar_info_video(self):
        url = self.entry_url.get().strip()
        if not es_url_youtube(url):
            self.after(0, self.mostrar_error_info, "URL no válida de YouTube.")
            self.after(0, self.fin_carga_info)
            return

        try:
            opts = {
                "quiet": True,
                "skip_download": True,
                "ffmpeg_location": FFMPEG_LOCATION,
                "socket_timeout": 15,
                "retries": 2,
                "extractor_retries": 2,
            }
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
            img = None
            if thumb:
                img = cargar_miniatura(thumb, timeout=10)

            self.after(0, self.actualizar_info_ui, titulo, duracion, max_altura, max_abr, img)

        except Exception as e:
            error_msg = str(e)
            if "timed out" in error_msg.lower():
                error_msg = "La conexión ha expirado. Comprueba tu conexión a Internet."
            self.after(0, self.mostrar_error_info, f"Error al obtener información:\n{error_msg}")
        finally:
            self.cargando_info = False
            self.after(0, self.fin_carga_info)

    def actualizar_info_ui(self, titulo, duracion, max_altura, max_abr, img):
        if img:
            self.thumbnail_image = img
            self.canvas_miniatura.configure(image=img, text="")
        else:
            self.canvas_miniatura.configure(text="Sin miniatura")

        # Mostrar también si se va a cortar
        info_text = f"Título: {titulo}\nDuración: {duracion}\n"
        if self.tiempo_inicio:
            info_text += f"Inicio desde: {segundos_a_hms(self.tiempo_inicio)}\n"
        if max_altura:
            info_text += f"Resolución máxima: {max_altura}p\n"
        else:
            info_text += "Resolución máxima: desconocida\n"
        if max_abr:
            info_text += f"Bitrate audio máx.: {max_abr} kbps\n"
        else:
            info_text += "Bitrate audio máx.: desconocido\n"

        self.text_info.configure(state="normal")
        self.text_info.delete("1.0", "end")
        self.text_info.insert("end", info_text)
        self.text_info.configure(state="disabled")

        self.actualizar_combo_video_quality(max_altura)
        self.actualizar_combo_mp3_bitrate(max_abr)

    def mostrar_error_info(self, error_msg):
        self.text_info.configure(state="normal")
        self.text_info.delete("1.0", "end")
        self.text_info.insert("end", error_msg)
        self.text_info.configure(state="disabled")
        self.canvas_miniatura.configure(text="Error")

    def fin_carga_info(self):
        self.config(cursor="")
        self.btn_descargar.configure(state="normal")

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
            self.current_item.actualizar_progreso(p, vel, eta, descargado, total, "Descargando…")
        elif status == "finished":
            self.current_item.actualizar_progreso(100, "N/A", "0s", "?", "?", "Convirtiendo…")
            self.progress_global.set(1.0)
            self.label_progreso_global.configure(text="Procesando…")

    # -------------------------
    # CONSTRUCCIÓN OPCIONES YDL (con corte por tiempo)
    # -------------------------
    def construir_ydl_opts(self, formato_salida):
        opts = {
            "outtmpl": os.path.join(self.carpeta_destino, "%(title)s.%(ext)s"),
            "progress_hooks": [self.hook_progreso],
            "ffmpeg_location": FFMPEG_LOCATION,
        }

        # Si hay tiempo de inicio, añadir sección de descarga
        if self.tiempo_inicio is not None:
            # download_sections recibe una lista con "*inicio-fin" o "*inicio-"
            # Para cortar desde inicio hasta el final: f"*{self.tiempo_inicio}-"
            opts["download_sections"] = [f"*{self.tiempo_inicio}-"]
            opts["force_keyframes_at_cuts"] = True

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

        # Si no hay info cargada o la URL cambió, cargarla (síncrono aquí)
        if self.info_video_actual is None or self.info_video_actual.get("webpage_url") != url:
            try:
                opts = {"quiet": True, "skip_download": True, "ffmpeg_location": FFMPEG_LOCATION}
                with yt_dlp.YoutubeDL(opts) as ydl:
                    info = ydl.extract_info(url, download=False)
                self.info_video_actual = info
            except Exception as e:
                messagebox.showerror("Error", f"No se pudo obtener la información:\n{e}")
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

        threading.Thread(target=self.descargar_thread, args=(url, formato_salida), daemon=True).start()

    def descargar_thread(self, url, formato_salida):
        try:
            # Obtener título
            info_opts = {"quiet": True, "skip_download": True, "ffmpeg_location": FFMPEG_LOCATION}
            with yt_dlp.YoutubeDL(info_opts) as ydl_info:
                info = ydl_info.extract_info(url, download=False)
            titulo = info.get("title", "Desconocido")

            self.after(0, lambda: setattr(self, 'current_item', self.crear_item_historial(titulo, formato_salida)))
            time.sleep(0.1)

            ydl_opts = self.construir_ydl_opts(formato_salida)
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                info_final = ydl.extract_info(url, download=True)
                nombre_archivo = ydl.prepare_filename(info_final)
                if "ext" in info_final:
                    base, _ = os.path.splitext(nombre_archivo)
                    nombre_archivo = base + "." + info_final["ext"]

            self.after(0, lambda: self.current_item.marcar_completado(nombre_archivo))
            self.after(0, lambda: self.label_progreso_global.configure(text="Completado"))
            #self.after(0, lambda: messagebox.showinfo("Éxito", "Descarga finalizada"))
        except Exception as e:
            self.after(0, lambda: self.current_item.marcar_error(str(e)) if self.current_item else None)
            self.after(0, lambda: messagebox.showerror("Error", f"Error durante la descarga:\n{e}"))
        finally:
            self.after(0, lambda: setattr(self, 'current_item', None))

# -----------------------------
# MAIN
# -----------------------------
if __name__ == "__main__":
    app = YouTubeDownloaderApp()
    app.mainloop()