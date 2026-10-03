# ------------------------------------------------------------
#
# YoutubeURL v1.2
# Creado por David Hidalgo Marsal (dhm@hotmail.es)
# Web de proyectos: https://dhmar91.github.io/
# Fecha: 25/03/2026
# Última actualización: 03/10/2026
#
# Aplicación para descargar vídeos y audio de YouTube
# con soporte para múltiples formatos, calidad máxima,
# miniatura, historial, progreso detallado y FFmpeg local
#
# ------------------------------------------------------------

import os
import sys
import io
import re
import urllib.request
import webbrowser
import tkinter as tk
import threading
import traceback

import yt_dlp
import customtkinter as ctk

from tkinter import filedialog, messagebox
from PIL import Image
from yt_dlp.utils import DownloadError


# ------------------------------------------------------------
# CONFIGURACIÓN GLOBAL
# ------------------------------------------------------------

ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")


# ------------------------------------------------------------
# RUTAS
# ------------------------------------------------------------
#
# Cuando se ejecuta normalmente:
#
#     BASE_DIR = carpeta donde está main.py
#
# Cuando se ejecuta el EXE generado con PyInstaller --onefile:
#
#     PyInstaller descomprime los recursos incluidos
#     temporalmente en una carpeta _MEIxxxxxx.
#
# Los recursos incluidos en el EXE, como FFmpeg, deben
# buscarse en esa carpeta temporal.
#
# Los archivos de configuración del usuario, en cambio,
# deben guardarse junto al EXE para que permanezcan entre
# ejecuciones.
#


if getattr(
    sys,
    "frozen",
    False
):

    # --------------------------------------------------------
    # CARPETA TEMPORAL DE PYINSTALLER
    # --------------------------------------------------------
    #
    # Aquí se encuentran los archivos incluidos mediante
    # --add-data, por ejemplo:
    #
    # _MEIxxxxxx\ffmpeg\
    #

    RESOURCE_DIR = (
        sys._MEIPASS
    )

    # --------------------------------------------------------
    # CARPETA REAL DEL EXE
    # --------------------------------------------------------
    #
    # Esta carpeta NO cambia entre ejecuciones.
    #

    APP_DIR = os.path.dirname(
        os.path.abspath(
            sys.executable
        )
    )

else:

    # --------------------------------------------------------
    # EJECUTANDO COMO PYTHON
    # --------------------------------------------------------

    RESOURCE_DIR = os.path.dirname(
        os.path.abspath(
            __file__
        )
    )

    APP_DIR = RESOURCE_DIR


# ------------------------------------------------------------
# COMPATIBILIDAD CON EL RESTO DEL PROGRAMA
# ------------------------------------------------------------
#
# BASE_DIR se mantiene como referencia a la carpeta real
# de la aplicación para que el resto del código no tenga
# que modificarse.
#
# En el EXE, BASE_DIR apunta a la carpeta donde está
# YoutubeURL.exe, NO a _MEIxxxxxx.
#

BASE_DIR = APP_DIR


# ------------------------------------------------------------
# FFMPEG
# ------------------------------------------------------------
#
# FFmpeg está incluido dentro del EXE mediante:
#
# --add-data "ffmpeg;ffmpeg"
#
# Por eso debe buscarse en RESOURCE_DIR.
#

FFMPEG_LOCATION = os.path.join(
    RESOURCE_DIR,
    "ffmpeg"
)


# ------------------------------------------------------------
# CONFIGURACIÓN DEL USUARIO
# ------------------------------------------------------------
#
# Estos archivos deben permanecer junto al EXE.
#

SETTINGS_FILE = os.path.join(
    APP_DIR,
    "settings.txt"
)


# ------------------------------------------------------------
# TÉRMINOS Y CONDICIONES
# ------------------------------------------------------------

# Cambia esta versión cuando modifiques los términos.
# Al cambiarla, el programa volverá a pedir aceptación.

TERMS_VERSION = "1.0"

TERMS_ACCEPTED_FILE = os.path.join(
    APP_DIR,
    "terms_accepted.txt"
)

TERMS_TEXT = """
TÉRMINOS Y CONDICIONES DE USO
YoutubeURL v1.2

Última actualización: 03/10/2026


1. OBJETO DEL PROGRAMA

YoutubeURL es una herramienta informática destinada a
facilitar la descarga y conversión de contenido disponible
en Internet mediante yt-dlp y FFmpeg.

El programa se proporciona como una herramienta de uso
general y su funcionamiento puede depender de servicios,
plataformas, bibliotecas o componentes externos.


2. RESPONSABILIDAD DEL USUARIO

El usuario es el único responsable del uso que haga del
programa y de los archivos que descargue mediante él.

Antes de descargar cualquier contenido, el usuario debe
asegurarse de que dispone de los derechos, permisos o
autorizaciones necesarios para realizar dicha descarga y
de que el uso realizado cumple la legislación aplicable.


3. DERECHOS SOBRE EL CONTENIDO

YoutubeURL no proporciona derechos, licencias ni
autorizaciones sobre los contenidos que puedan descargarse.

El usuario debe respetar los derechos de autor, derechos de
propiedad intelectual, derechos de imagen y cualquier otro
derecho aplicable al contenido descargado.


4. CONDICIONES DE LAS PLATAFORMAS

El usuario es responsable de comprobar y respetar las
condiciones de uso de la plataforma o servicio desde el que
obtenga el contenido.

El autor de YoutubeURL no controla las condiciones, cambios,
restricciones o disponibilidad de servicios externos.


5. RESPONSABILIDAD DEL AUTOR

El autor de YoutubeURL desarrolla y proporciona el programa
como una herramienta informática.

El autor no controla el uso que cada usuario haga del
programa ni de los contenidos que pueda obtener mediante él.

En consecuencia, el usuario asume la responsabilidad derivada
del uso que realice del programa y de los contenidos que
descargue, dentro de los límites establecidos por la
legislación aplicable.


6. SERVICIOS Y COMPONENTES EXTERNOS

YoutubeURL utiliza componentes y proyectos externos, entre
ellos yt-dlp y FFmpeg.

El funcionamiento de estos componentes puede cambiar con el
tiempo debido a modificaciones técnicas, cambios en servicios
externos o cualquier otra circunstancia ajena al autor de
YoutubeURL.


7. ACEPTACIÓN

Al pulsar el botón "Aceptar", el usuario declara que ha leído,
comprendido y aceptado estos términos y condiciones de uso.

Si no está de acuerdo con estos términos, deberá pulsar
"Salir" y cerrar el programa.


Versión de los términos: 1.0
"""


def terminos_aceptados():
    """
    Comprueba si el usuario ha aceptado la versión actual
    de los términos.
    """

    try:

        if not os.path.isfile(
            TERMS_ACCEPTED_FILE
        ):
            return False

        with open(
            TERMS_ACCEPTED_FILE,
            "r",
            encoding="utf-8"
        ) as f:

            version = f.read().strip()

        return version == TERMS_VERSION

    except Exception:

        return False


def guardar_aceptacion_terminos():
    """
    Guarda la versión de términos aceptada.
    """

    try:

        with open(
            TERMS_ACCEPTED_FILE,
            "w",
            encoding="utf-8"
        ) as f:

            f.write(TERMS_VERSION)

        return True

    except Exception:

        return False


# ------------------------------------------------------------
# CONFIGURACIÓN DE FORMATOS
# ------------------------------------------------------------

FORMATOS_SALIDA = [
    "Original",
    "MP4",
    "MKV",
    "WEBM",
    "MP3",
    "WAV",
    "AAC",
    "OGG",
    "FLAC"
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


# ------------------------------------------------------------
# URL YOUTUBE
# ------------------------------------------------------------

YOUTUBE_REGEX = re.compile(
    r"^(https?://)?"
    r"(www\.)?"
    r"(youtube\.com|youtu\.be|m\.youtube\.com)"
    r"/",
    re.IGNORECASE
)


# ------------------------------------------------------------
# FUNCIONES AUXILIARES
# ------------------------------------------------------------

def es_url_youtube(url):

    return bool(
        YOUTUBE_REGEX.match(
            url.strip()
        )
    )


def segundos_a_hms(seg):

    if seg is None:
        return "Desconocido"

    try:

        seg = int(seg)

    except (
        ValueError,
        TypeError
    ):

        return "Desconocido"

    h = seg // 3600

    m = (
        seg % 3600
    ) // 60

    s = seg % 60

    if h > 0:

        return (
            f"{h:02d}:"
            f"{m:02d}:"
            f"{s:02d}"
        )

    return (
        f"{m:02d}:"
        f"{s:02d}"
    )


def cargar_miniatura(
    url,
    timeout=10
):

    try:

        with urllib.request.urlopen(
            url,
            timeout=timeout
        ) as resp:

            data = resp.read()

        img = Image.open(
            io.BytesIO(data)
        ).convert("RGBA")

        img.thumbnail(
            (260, 260)
        )

        return img

    except Exception:

        return None


def formatear_tamano(
    bytes_val
):

    if bytes_val is None:
        return "Desconocido"

    try:

        f = float(
            bytes_val
        )

    except (
        ValueError,
        TypeError
    ):

        return "Desconocido"

    unidades = [
        "B",
        "KB",
        "MB",
        "GB",
        "TB"
    ]

    i = 0

    while (
        f >= 1024
        and i < len(unidades) - 1
    ):

        f /= 1024.0
        i += 1

    return (
        f"{f:.2f} "
        f"{unidades[i]}"
    )


def cargar_carpeta_guardada():

    if os.path.exists(
        SETTINGS_FILE
    ):

        try:

            with open(
                SETTINGS_FILE,
                "r",
                encoding="utf-8"
            ) as f:

                ruta = f.read().strip()

            if (
                ruta
                and os.path.isdir(ruta)
            ):

                return ruta

        except Exception:

            pass

    return BASE_DIR


def guardar_carpeta(
    ruta
):

    try:

        with open(
            SETTINGS_FILE,
            "w",
            encoding="utf-8"
        ) as f:

            f.write(ruta)

    except Exception:

        pass


def parse_t_param(
    t_str
):

    """
    Convierte un parámetro t de YouTube a segundos.

    Ejemplos:
        20       -> 20
        1m20s    -> 80
        1:20     -> 80
        1h2m3s   -> 3723
    """

    if not t_str:
        return None

    t_str = (
        t_str
        .strip()
        .lower()
    )

    # Solo segundos

    if t_str.isdigit():

        return int(
            t_str
        )

    # hh:mm:ss / mm:ss

    if ":" in t_str:

        try:

            parts = t_str.split(":")

            if len(parts) == 2:

                return (
                    int(parts[0]) * 60
                    + int(parts[1])
                )

            if len(parts) == 3:

                return (
                    int(parts[0]) * 3600
                    + int(parts[1]) * 60
                    + int(parts[2])
                )

        except ValueError:

            return None

    # 1h2m3s / 1m20s / 20s

    match = re.fullmatch(
        r"(?:(\d+)h)?"
        r"(?:(\d+)m)?"
        r"(?:(\d+)s)?",
        t_str
    )

    if match:

        if not any(
            match.groups()
        ):

            return None

        h = (
            int(match.group(1))
            if match.group(1)
            else 0
        )

        m = (
            int(match.group(2))
            if match.group(2)
            else 0
        )

        s = (
            int(match.group(3))
            if match.group(3)
            else 0
        )

        return (
            h * 3600
            + m * 60
            + s
        )

    return None


# ------------------------------------------------------------
# ITEM HISTORIAL
# ------------------------------------------------------------

class DownloadItem(
    ctk.CTkFrame
):

    def __init__(
        self,
        master,
        titulo,
        formato,
        carpeta_destino,
        *args,
        **kwargs
    ):

        super().__init__(
            master,
            *args,
            **kwargs
        )

        self.titulo = titulo
        self.formato = formato
        self.carpeta_destino = carpeta_destino

        self.archivo_salida = None

        # ----------------------------------------------------
        # ESTADO FINAL
        # ----------------------------------------------------

        self.finalizado = False
        self.error = False

        # ----------------------------------------------------
        # COLUMNAS
        # ----------------------------------------------------

        self.grid_columnconfigure(
            0,
            weight=1
        )

        # ----------------------------------------------------
        # TÍTULO
        # ----------------------------------------------------

        self.label_titulo = ctk.CTkLabel(
            self,
            text=f"{titulo} [{formato}]",
            anchor="w"
        )

        self.label_titulo.grid(
            row=0,
            column=0,
            sticky="ew",
            padx=5,
            pady=(5, 0)
        )

        # ----------------------------------------------------
        # PROGRESO
        # ----------------------------------------------------

        self.progress = ctk.CTkProgressBar(
            self
        )

        self.progress.set(
            0
        )

        self.progress.grid(
            row=1,
            column=0,
            sticky="ew",
            padx=5
        )

        # ----------------------------------------------------
        # ESTADO
        # ----------------------------------------------------

        self.label_estado = ctk.CTkLabel(
            self,
            text="Esperando…",
            anchor="w"
        )

        self.label_estado.grid(
            row=2,
            column=0,
            sticky="ew",
            padx=5,
            pady=(2, 5)
        )

        # ----------------------------------------------------
        # ABRIR CARPETA
        # ----------------------------------------------------

        self.btn_abrir = ctk.CTkButton(
            self,
            text="Abrir carpeta",
            width=120,
            command=self.abrir_carpeta
        )

        self.btn_abrir.grid(
            row=0,
            column=1,
            rowspan=3,
            padx=5,
            pady=5
        )

    def actualizar_progreso(
        self,
        p,
        vel,
        eta,
        descargado,
        total,
        estado
    ):

        if self.finalizado:
            return

        p = max(
            0,
            min(
                100,
                float(p)
            )
        )

        self.progress.set(
            p / 100.0
        )

        self.label_estado.configure(
            text=(
                f"{p:.1f}% — {estado}\n"
                f"{descargado} / {total} — "
                f"{vel} — ETA {eta}"
            )
        )

    def marcar_completado(
        self,
        archivo
    ):

        self.archivo_salida = archivo

        self.finalizado = True
        self.error = False

        self.progress.set(
            1.0
        )

        self.label_estado.configure(
            text="100% — Completado"
        )

    def marcar_error(
        self,
        msg
    ):

        self.error = True
        self.finalizado = True

        self.label_estado.configure(
            text=f"Error: {msg}"
        )

    def abrir_carpeta(
        self
    ):

        carpeta = (
            os.path.dirname(
                self.archivo_salida
            )
            if self.archivo_salida
            else self.carpeta_destino
        )

        if not carpeta:
            return

        if os.name == "nt":

            try:

                os.startfile(
                    carpeta
                )

            except Exception:

                pass

        else:

            webbrowser.open(
                f"file://{carpeta}"
            )


# ------------------------------------------------------------
# APLICACIÓN PRINCIPAL
# ------------------------------------------------------------

class YouTubeDownloaderApp(
    ctk.CTk
):

    def __init__(
        self
    ):

        super().__init__()

        self.title(
            "YoutubeURL v1.2"
        )

        # ----------------------------------------------------
        # TAMAÑO NORMAL
        # ----------------------------------------------------

        self.geometry(
            "1000x600"
        )

        self.minsize(
            900,
            550
        )

        self.resizable(
            True,
            True
        )

        # ----------------------------------------------------
        # VARIABLES
        # ----------------------------------------------------

        self.carpeta_destino = (
            cargar_carpeta_guardada()
        )

        self.info_video_actual = None
        self.thumbnail_image = None
        self.current_item = None

        self.cargando_info = False
        self.descargando = False

        self.tiempo_inicio = None

        # ----------------------------------------------------
        # PRIMER INICIO
        # ----------------------------------------------------

        self.withdraw()

        if not terminos_aceptados():

            aceptado = (
                self.mostrar_terminos()
            )

            if not aceptado:

                self.destroy()

                return

        # ----------------------------------------------------
        # CREAR INTERFAZ
        # ----------------------------------------------------

        self.crear_ui()

        # ----------------------------------------------------
        # MOSTRAR VENTANA
        # ----------------------------------------------------

        self.after(
            100,
            self.mostrar_ventana_principal
        )

    # --------------------------------------------------------
    # MOSTRAR VENTANA PRINCIPAL
    # --------------------------------------------------------

    def mostrar_ventana_principal(
        self
    ):

        try:

            self.deiconify()

            self.update_idletasks()

            ancho = 1000
            alto = 600

            pantalla_ancho = (
                self.winfo_screenwidth()
            )

            pantalla_alto = (
                self.winfo_screenheight()
            )

            x = max(
                0,
                int(
                    (
                        pantalla_ancho
                        - ancho
                    ) / 2
                )
            )

            y = max(
                0,
                int(
                    (
                        pantalla_alto
                        - alto
                    ) / 2
                )
            )

            self.geometry(
                f"{ancho}x{alto}+{x}+{y}"
            )

            self.lift()

            self.attributes(
                "-topmost",
                True
            )

            self.after(
                200,
                lambda:
                self.attributes(
                    "-topmost",
                    False
                )
            )

            self.focus_force()

        except Exception:

            try:

                self.deiconify()
                self.lift()
                self.focus_force()

            except Exception:

                pass

    # --------------------------------------------------------
    # TÉRMINOS Y CONDICIONES
    # --------------------------------------------------------

    def mostrar_terminos(
        self
    ):

        aceptado = False

        # ----------------------------------------------------
        # VENTANA
        # ----------------------------------------------------

        ventana = ctk.CTkToplevel(
            self
        )

        ventana.title(
            "Términos y condiciones de uso"
        )

        ancho = 700
        alto = 600

        pantalla_ancho = (
            self.winfo_screenwidth()
        )

        pantalla_alto = (
            self.winfo_screenheight()
        )

        x = max(
            0,
            int(
                (
                    pantalla_ancho
                    - ancho
                ) / 2
            )
        )

        y = max(
            0,
            int(
                (
                    pantalla_alto
                    - alto
                ) / 2
            )
        )

        ventana.geometry(
            f"{ancho}x{alto}+{x}+{y}"
        )

        ventana.minsize(
            600,
            500
        )

        ventana.resizable(
            True,
            True
        )

        # ----------------------------------------------------
        # CERRAR
        # ----------------------------------------------------

        def cerrar_terminos():

            ventana.destroy()

        ventana.protocol(
            "WM_DELETE_WINDOW",
            cerrar_terminos
        )

        # ----------------------------------------------------
        # MODAL
        # ----------------------------------------------------

        ventana.transient(
            self
        )

        ventana.grab_set()

        # ----------------------------------------------------
        # GRID
        # ----------------------------------------------------

        ventana.grid_columnconfigure(
            0,
            weight=1
        )

        ventana.grid_rowconfigure(
            1,
            weight=1
        )

        # ----------------------------------------------------
        # TÍTULO
        # ----------------------------------------------------

        label_titulo = ctk.CTkLabel(
            ventana,
            text="Términos y condiciones de uso",
            font=ctk.CTkFont(
                size=22,
                weight="bold"
            )
        )

        label_titulo.grid(
            row=0,
            column=0,
            sticky="ew",
            padx=20,
            pady=(20, 10)
        )

        # ----------------------------------------------------
        # TEXTO
        # ----------------------------------------------------

        textbox = ctk.CTkTextbox(
            ventana,
            wrap="word"
        )

        textbox.grid(
            row=1,
            column=0,
            sticky="nsew",
            padx=20,
            pady=(0, 15)
        )

        textbox.insert(
            "1.0",
            TERMS_TEXT.strip()
        )

        textbox.configure(
            state="disabled"
        )

        # ----------------------------------------------------
        # BOTONES
        # ----------------------------------------------------

        frame_botones = ctk.CTkFrame(
            ventana,
            fg_color="transparent"
        )

        frame_botones.grid(
            row=2,
            column=0,
            sticky="ew",
            padx=20,
            pady=(0, 20)
        )

        frame_botones.grid_columnconfigure(
            0,
            weight=1
        )

        frame_botones.grid_columnconfigure(
            1,
            weight=1
        )

        # ----------------------------------------------------
        # SALIR
        # ----------------------------------------------------

        def salir():

            nonlocal aceptado

            aceptado = False

            try:

                ventana.grab_release()

            except Exception:

                pass

            ventana.destroy()

        btn_salir = ctk.CTkButton(
            frame_botones,
            text="Salir",
            height=40,
            command=salir
        )

        btn_salir.grid(
            row=0,
            column=0,
            sticky="ew",
            padx=(0, 5)
        )

        # ----------------------------------------------------
        # ACEPTAR
        # ----------------------------------------------------

        def aceptar():

            nonlocal aceptado

            if not guardar_aceptacion_terminos():

                messagebox.showerror(
                    "Error",
                    (
                        "No se ha podido guardar "
                        "la aceptación de los "
                        "términos y condiciones.\n\n"
                        "El programa no puede continuar."
                    ),
                    parent=ventana
                )

                return

            aceptado = True

            try:

                ventana.grab_release()

            except Exception:

                pass

            ventana.destroy()

        btn_aceptar = ctk.CTkButton(
            frame_botones,
            text="Aceptar",
            height=40,
            command=aceptar
        )

        btn_aceptar.grid(
            row=0,
            column=1,
            sticky="ew",
            padx=(5, 0)
        )

        # ----------------------------------------------------
        # MOSTRAR
        # ----------------------------------------------------

        ventana.update_idletasks()

        ventana.lift()

        ventana.attributes(
            "-topmost",
            True
        )

        ventana.focus_force()

        # ----------------------------------------------------
        # ESPERAR
        # ----------------------------------------------------

        self.wait_window(
            ventana
        )

        return aceptado

    # --------------------------------------------------------
    # UI
    # --------------------------------------------------------

    def crear_ui(
        self
    ):

        self.grid_columnconfigure(
            0,
            weight=2
        )

        self.grid_columnconfigure(
            1,
            weight=3
        )

        self.grid_rowconfigure(
            0,
            weight=1
        )

        # ----------------------------------------------------
        # PANEL IZQUIERDO
        # ----------------------------------------------------

        self.frame_left = ctk.CTkFrame(
            self
        )

        self.frame_left.grid(
            row=0,
            column=0,
            sticky="nsew",
            padx=10,
            pady=10
        )

        self.frame_left.grid_columnconfigure(
            0,
            weight=1
        )

        # ----------------------------------------------------
        # PANEL DERECHO
        # ----------------------------------------------------

        self.frame_right = ctk.CTkFrame(
            self
        )

        self.frame_right.grid(
            row=0,
            column=1,
            sticky="nsew",
            padx=10,
            pady=10
        )

        self.frame_right.grid_columnconfigure(
            0,
            weight=1
        )

        self.frame_right.grid_rowconfigure(
            3,
            weight=1
        )

        self.frame_right.grid_rowconfigure(
            5,
            weight=1
        )

        # ----------------------------------------------------
        # CABECERA
        # ----------------------------------------------------

        self.label_titulo = ctk.CTkLabel(
            self.frame_left,
            text="YoutubeURL 1.2",
            font=ctk.CTkFont(
                size=22,
                weight="bold"
            ),
            text_color="#4da6ff"
        )

        self.label_titulo.grid(
            row=0,
            column=0,
            sticky="w",
            padx=10,
            pady=(10, 0)
        )

        self.label_autor_top = ctk.CTkLabel(
            self.frame_left,
            text=(
                "Creado por David Hidalgo Marsal - "
                "dhm@hotmail.es - "
                "dhmar91.github.io"
            ),
            font=ctk.CTkFont(
                size=12
            ),
            text_color="#4da6ff"
        )

        self.label_autor_top.grid(
            row=1,
            column=0,
            sticky="w",
            padx=10,
            pady=(0, 10)
        )

        # ----------------------------------------------------
        # TEMA
        # ----------------------------------------------------

        self.label_tema = ctk.CTkLabel(
            self.frame_left,
            text="Tema"
        )

        self.label_tema.grid(
            row=2,
            column=0,
            sticky="w",
            padx=10
        )

        self.combo_tema = ctk.CTkComboBox(
            self.frame_left,
            values=[
                "Oscuro",
                "Claro"
            ],
            state="readonly",
            command=self.cambiar_tema
        )

        self.combo_tema.set(
            "Oscuro"
        )

        self.combo_tema.grid(
            row=3,
            column=0,
            sticky="ew",
            padx=10,
            pady=(0, 10)
        )

        # ----------------------------------------------------
        # URL
        # ----------------------------------------------------

        self.label_url = ctk.CTkLabel(
            self.frame_left,
            text="URL de YouTube"
        )

        self.label_url.grid(
            row=4,
            column=0,
            sticky="w",
            padx=10
        )

        self.entry_url = ctk.CTkEntry(
            self.frame_left,
            placeholder_text="Pega aquí la URL"
        )

        self.entry_url.grid(
            row=5,
            column=0,
            sticky="ew",
            padx=10,
            pady=(0, 10)
        )

        self.entry_url.bind(
            "<KeyRelease>",
            self.evento_url_cambiada
        )

        self.entry_url.bind(
            "<Button-3>",
            self.mostrar_menu_contextual
        )

        self.entry_url.bind(
            "<Control-v>",
            self.pegar_url
        )

        self.entry_url.bind(
            "<Control-c>",
            self.copiar_url
        )

        # ----------------------------------------------------
        # CARPETA
        # ----------------------------------------------------

        self.label_carpeta = ctk.CTkLabel(
            self.frame_left,
            text="Carpeta destino"
        )

        self.label_carpeta.grid(
            row=6,
            column=0,
            sticky="w",
            padx=10
        )

        self.frame_carpeta = ctk.CTkFrame(
            self.frame_left
        )

        self.frame_carpeta.grid(
            row=7,
            column=0,
            sticky="ew",
            padx=10,
            pady=(0, 10)
        )

        self.frame_carpeta.grid_columnconfigure(
            0,
            weight=1
        )

        self.entry_carpeta = ctk.CTkEntry(
            self.frame_carpeta
        )

        self.entry_carpeta.grid(
            row=0,
            column=0,
            sticky="ew",
            padx=(0, 5)
        )

        self.entry_carpeta.insert(
            0,
            self.carpeta_destino
        )

        self.btn_carpeta = ctk.CTkButton(
            self.frame_carpeta,
            text="Elegir",
            width=80,
            command=self.elegir_carpeta
        )

        self.btn_carpeta.grid(
            row=0,
            column=1
        )

        # ----------------------------------------------------
        # FORMATO
        # ----------------------------------------------------

        self.label_formato = ctk.CTkLabel(
            self.frame_left,
            text="Formato de salida"
        )

        self.label_formato.grid(
            row=8,
            column=0,
            sticky="w",
            padx=10
        )

        self.combo_formato = ctk.CTkComboBox(
            self.frame_left,
            values=FORMATOS_SALIDA,
            state="readonly"
        )

        self.combo_formato.set(
            "Original"
        )

        self.combo_formato.grid(
            row=9,
            column=0,
            sticky="ew",
            padx=10,
            pady=(0, 10)
        )

        # ----------------------------------------------------
        # CALIDAD
        # ----------------------------------------------------

        self.label_video_quality = ctk.CTkLabel(
            self.frame_left,
            text="Calidad de vídeo (máxima)"
        )

        self.label_video_quality.grid(
            row=10,
            column=0,
            sticky="w",
            padx=10
        )

        self.combo_video_quality = ctk.CTkComboBox(
            self.frame_left,
            values=[
                v[0]
                for v in VIDEO_CALIDADES_MAX
            ],
            state="readonly"
        )

        self.combo_video_quality.set(
            "Original"
        )

        self.combo_video_quality.grid(
            row=11,
            column=0,
            sticky="ew",
            padx=10,
            pady=(0, 10)
        )

        # ----------------------------------------------------
        # BITRATE
        # ----------------------------------------------------

        self.label_mp3_bitrate = ctk.CTkLabel(
            self.frame_left,
            text="Bitrate MP3 (máximo)"
        )

        self.label_mp3_bitrate.grid(
            row=12,
            column=0,
            sticky="w",
            padx=10
        )

        self.combo_mp3_bitrate = ctk.CTkComboBox(
            self.frame_left,
            values=[
                b[0]
                for b in MP3_BITRATES_MAX
            ],
            state="readonly"
        )

        self.combo_mp3_bitrate.set(
            "Original"
        )

        self.combo_mp3_bitrate.grid(
            row=13,
            column=0,
            sticky="ew",
            padx=10,
            pady=(0, 10)
        )

        # ----------------------------------------------------
        # PROGRESO GLOBAL
        # ----------------------------------------------------

        self.progress_global = ctk.CTkProgressBar(
            self.frame_left
        )

        self.progress_global.set(
            0
        )

        self.progress_global.grid(
            row=14,
            column=0,
            sticky="ew",
            padx=10
        )

        self.label_progreso_global = ctk.CTkLabel(
            self.frame_left,
            text="0%"
        )

        self.label_progreso_global.grid(
            row=15,
            column=0,
            sticky="e",
            padx=10,
            pady=(0, 10)
        )

        # ----------------------------------------------------
        # DESCARGAR
        # ----------------------------------------------------

        self.btn_descargar = ctk.CTkButton(
            self.frame_left,
            text="Descargar",
            command=self.descargar
        )

        self.btn_descargar.grid(
            row=16,
            column=0,
            sticky="ew",
            padx=10,
            pady=(5, 10)
        )

        # ----------------------------------------------------
        # PANEL DERECHO
        # ----------------------------------------------------

        self.label_miniatura = ctk.CTkLabel(
            self.frame_right,
            text="Miniatura"
        )

        self.label_miniatura.grid(
            row=0,
            column=0,
            sticky="w",
            padx=10,
            pady=(10, 0)
        )

        self.canvas_miniatura = ctk.CTkLabel(
            self.frame_right,
            text=""
        )

        self.canvas_miniatura.grid(
            row=1,
            column=0,
            pady=(0, 10)
        )

        self.label_info = ctk.CTkLabel(
            self.frame_right,
            text="Información del vídeo"
        )

        self.label_info.grid(
            row=2,
            column=0,
            sticky="w",
            padx=10
        )

        self.text_info = ctk.CTkTextbox(
            self.frame_right,
            height=120
        )

        self.text_info.grid(
            row=3,
            column=0,
            sticky="nsew",
            padx=10,
            pady=(0, 10)
        )

        self.text_info.configure(
            state="disabled"
        )

        self.label_historial = ctk.CTkLabel(
            self.frame_right,
            text="Historial de descargas"
        )

        self.label_historial.grid(
            row=4,
            column=0,
            sticky="w",
            padx=10
        )

        self.scroll_historial = ctk.CTkScrollableFrame(
            self.frame_right
        )

        self.scroll_historial.grid(
            row=5,
            column=0,
            sticky="nsew",
            padx=10,
            pady=(0, 10)
        )

        self.scroll_historial.grid_columnconfigure(
            0,
            weight=1
        )

    # --------------------------------------------------------
    # TEMA
    # --------------------------------------------------------

    def cambiar_tema(
        self,
        valor
    ):

        ctk.set_appearance_mode(
            "light"
            if valor == "Claro"
            else "dark"
        )

    # --------------------------------------------------------
    # URL
    # --------------------------------------------------------

    def evento_url_cambiada(
        self,
        event=None
    ):

        url = (
            self.entry_url
            .get()
            .strip()
        )

        if (
            url.startswith("http")
            and not self.cargando_info
            and es_url_youtube(url)
        ):

            self.tiempo_inicio = (
                self.extraer_t_param(
                    url
                )
            )

            self.cargar_info_video_thread()

        elif (
            url.startswith("http")
            and not es_url_youtube(url)
        ):

            self.mostrar_error_info(
                "La URL no pertenece a YouTube.\n"
                "Por favor, introduce una URL válida."
            )

    def extraer_t_param(
        self,
        url
    ):

        match = re.search(
            r"[?&](?:t|start)=([^&#]+)",
            url,
            re.IGNORECASE
        )

        if match:

            return parse_t_param(
                match.group(1)
            )

        return None

    # --------------------------------------------------------
    # CARPETA
    # --------------------------------------------------------

    def elegir_carpeta(
        self
    ):

        carpeta = (
            filedialog.askdirectory()
        )

        if carpeta:

            self.carpeta_destino = (
                carpeta
            )

            self.entry_carpeta.delete(
                0,
                "end"
            )

            self.entry_carpeta.insert(
                0,
                carpeta
            )

            guardar_carpeta(
                carpeta
            )

    # --------------------------------------------------------
    # PORTAPAPELES
    # --------------------------------------------------------

    def limpiar_url(
        self,
        url
    ):

        url = url.strip()

        # Conservamos t/start.

        match = re.match(
            r"^(.*?)(?:[?&](?:t|start)=([^&#]+))",
            url,
            re.IGNORECASE
        )

        if match:

            base = match.group(1)

            tiempo = match.group(2)

            separador = (
                "&"
                if "?" in base
                else "?"
            )

            return (
                f"{base}"
                f"{separador}"
                f"t={tiempo}"
            )

        # Eliminamos parámetros adicionales.

        if "&" in url:

            url = url.split(
                "&",
                1
            )[0]

        return url

    def pegar_url(
        self,
        event=None
    ):

        try:

            texto = (
                self.clipboard_get()
            )

            t_seg = (
                self.extraer_t_param(
                    texto
                )
            )

            self.tiempo_inicio = (
                t_seg
            )

            texto_limpio = (
                self.limpiar_url(
                    texto
                )
            )

            self.entry_url.delete(
                0,
                "end"
            )

            self.entry_url.insert(
                0,
                texto_limpio
            )

            self.evento_url_cambiada()

        except Exception:

            pass

        return "break"

    def copiar_url(
        self,
        event=None
    ):

        url = (
            self.entry_url.get()
        )

        if url:

            self.clipboard_clear()

            self.clipboard_append(
                url
            )

        return "break"

    def mostrar_menu_contextual(
        self,
        event
    ):

        menu = tk.Menu(
            self,
            tearoff=False
        )

        menu.add_command(
            label="Pegar",
            command=self.pegar_url
        )

        menu.add_command(
            label="Copiar",
            command=self.copiar_url
        )

        menu.post(
            event.x_root,
            event.y_root
        )

    # --------------------------------------------------------
    # INFORMACIÓN DEL VÍDEO
    # --------------------------------------------------------

    def cargar_info_video_thread(
        self
    ):

        if self.cargando_info:
            return

        self.cargando_info = True

        self.config(
            cursor="watch"
        )

        self.btn_descargar.configure(
            state="disabled"
        )

        threading.Thread(
            target=self.cargar_info_video,
            daemon=True
        ).start()

    def cargar_info_video(
        self
    ):

        # Capturamos la URL antes del hilo.

        url = (
            self.entry_url
            .get()
            .strip()
        )

        if not es_url_youtube(
            url
        ):

            self.after(
                0,
                self.mostrar_error_info,
                "URL no válida de YouTube."
            )

            self.after(
                0,
                self.fin_carga_info
            )

            return

        try:

            opts = {
                "quiet": True,
                "skip_download": True,
                "ffmpeg_location":
                    FFMPEG_LOCATION,
                "socket_timeout": 30,
                "retries": 3,
                "extractor_retries": 3,
            }

            with yt_dlp.YoutubeDL(
                opts
            ) as ydl:

                info = ydl.extract_info(
                    url,
                    download=False
                )

            self.info_video_actual = (
                info
            )

            titulo = info.get(
                "title",
                "Desconocido"
            )

            duracion = segundos_a_hms(
                info.get(
                    "duration"
                )
            )

            formatos = info.get(
                "formats",
                []
            )

            alturas = sorted({
                f.get("height")
                for f in formatos
                if f.get("height")
            })

            max_altura = (
                max(alturas)
                if alturas
                else None
            )

            abr_list = []

            for f in formatos:

                valor = (
                    f.get("abr")
                    or
                    f.get("tbr")
                )

                if valor:

                    try:

                        abr_list.append(
                            int(
                                float(
                                    valor
                                )
                            )
                        )

                    except (
                        ValueError,
                        TypeError
                    ):

                        pass

            max_abr = (
                max(abr_list)
                if abr_list
                else None
            )

            thumb = info.get(
                "thumbnail"
            )

            img = None

            if thumb:

                img = cargar_miniatura(
                    thumb,
                    timeout=10
                )

            self.after(
                0,
                self.actualizar_info_ui,
                titulo,
                duracion,
                max_altura,
                max_abr,
                img
            )

        except Exception as e:

            error_msg = (
                self.obtener_error_detallado(
                    e
                )
            )

            if (
                "timed out"
                in error_msg.lower()
            ):

                error_msg = (
                    "La conexión ha expirado. "
                    "Comprueba tu conexión a Internet."
                )

            self.after(
                0,
                self.mostrar_error_info,
                (
                    "Error al obtener información:\n"
                    f"{error_msg}"
                )
            )

        finally:

            self.cargando_info = False

            self.after(
                0,
                self.fin_carga_info
            )

    def actualizar_info_ui(
        self,
        titulo,
        duracion,
        max_altura,
        max_abr,
        img
    ):

        if img:

            self.thumbnail_image = (
                ctk.CTkImage(
                    light_image=img,
                    dark_image=img,
                    size=img.size
                )
            )

            self.canvas_miniatura.configure(
                image=self.thumbnail_image,
                text=""
            )

        else:

            self.thumbnail_image = None

            self.canvas_miniatura.configure(
                image=None,
                text="Sin miniatura"
            )

        info_text = (
            f"Título: {titulo}\n"
            f"Duración: {duracion}\n"
        )

        if self.tiempo_inicio is not None:

            info_text += (
                "Inicio desde: "
                f"{segundos_a_hms(self.tiempo_inicio)}\n"
            )

        if max_altura:

            info_text += (
                "Resolución máxima: "
                f"{max_altura}p\n"
            )

        else:

            info_text += (
                "Resolución máxima: "
                "desconocida\n"
            )

        if max_abr:

            info_text += (
                "Bitrate audio máx.: "
                f"{max_abr} kbps\n"
            )

        else:

            info_text += (
                "Bitrate audio máx.: "
                "desconocido\n"
            )

        self.text_info.configure(
            state="normal"
        )

        self.text_info.delete(
            "1.0",
            "end"
        )

        self.text_info.insert(
            "end",
            info_text
        )

        self.text_info.configure(
            state="disabled"
        )

        self.actualizar_combo_video_quality(
            max_altura
        )

        self.actualizar_combo_mp3_bitrate(
            max_abr
        )

    def mostrar_error_info(
        self,
        error_msg
    ):

        self.text_info.configure(
            state="normal"
        )

        self.text_info.delete(
            "1.0",
            "end"
        )

        self.text_info.insert(
            "end",
            error_msg
        )

        self.text_info.configure(
            state="disabled"
        )

        self.canvas_miniatura.configure(
            image=None,
            text="Error"
        )

        self.thumbnail_image = None

    def fin_carga_info(
        self
    ):

        self.config(
            cursor=""
        )

        if not self.descargando:

            self.btn_descargar.configure(
                state="normal"
            )

    def actualizar_combo_video_quality(
        self,
        max_altura
    ):

        valores = []

        for texto, altura in (
            VIDEO_CALIDADES_MAX
        ):

            if altura is None:

                valores.append(
                    texto
                )

            elif (
                max_altura is None
                or altura <= max_altura
            ):

                valores.append(
                    texto
                )

        if not valores:

            valores = [
                "Original"
            ]

        self.combo_video_quality.configure(
            values=valores
        )

        self.combo_video_quality.set(
            "Original"
        )

    def actualizar_combo_mp3_bitrate(
        self,
        max_abr
    ):

        valores = []

        for texto, bitrate in (
            MP3_BITRATES_MAX
        ):

            if bitrate is None:

                valores.append(
                    texto
                )

            elif (
                max_abr is None
                or bitrate <= max_abr
            ):

                valores.append(
                    texto
                )

        if not valores:

            valores = [
                "Original"
            ]

        self.combo_mp3_bitrate.configure(
            values=valores
        )

        self.combo_mp3_bitrate.set(
            "Original"
        )

    # --------------------------------------------------------
    # PROGRESO
    # --------------------------------------------------------

    def hook_progreso(
        self,
        d,
        item
    ):

        if item is None:
            return

        if item.finalizado:
            return

        status = d.get(
            "status"
        )

        if status == "downloading":

            percent_str = d.get(
                "_percent_str",
                "0%"
            )

            try:

                p = float(
                    percent_str
                    .replace(
                        "%",
                        ""
                    )
                    .strip()
                )

            except (
                ValueError,
                TypeError
            ):

                p = 0.0

            velocidad = d.get(
                "_speed_str",
                "N/A"
            )

            eta = d.get(
                "_eta_str",
                "N/A"
            )

            total = formatear_tamano(
                d.get(
                    "total_bytes"
                )
                or
                d.get(
                    "total_bytes_estimate"
                )
            )

            descargado = formatear_tamano(
                d.get(
                    "downloaded_bytes"
                )
            )

            self.after(
                0,
                self.actualizar_progreso_ui,
                item,
                p,
                velocidad,
                eta,
                descargado,
                total
            )

        elif status == "finished":

            self.after(
                0,
                self.actualizar_finalizando_ui,
                item
            )

    def actualizar_progreso_ui(
        self,
        item,
        p,
        velocidad,
        eta,
        descargado,
        total
    ):

        if item is not self.current_item:
            return

        if item.finalizado:
            return

        p = max(
            0,
            min(
                100,
                p
            )
        )

        self.progress_global.set(
            p / 100.0
        )

        self.label_progreso_global.configure(
            text=f"{p:.1f}%"
        )

        item.actualizar_progreso(
            p,
            velocidad,
            eta,
            descargado,
            total,
            "Descargando…"
        )

    def actualizar_finalizando_ui(
        self,
        item
    ):

        if item is not self.current_item:
            return

        if item.finalizado:
            return

        item.actualizar_progreso(
            100,
            "N/A",
            "0s",
            "?",
            "?",
            "Procesando…"
        )

        self.progress_global.set(
            1.0
        )

        self.label_progreso_global.configure(
            text="Procesando…"
        )

    # --------------------------------------------------------
    # CONSTRUCCIÓN OPCIONES YDL
    # --------------------------------------------------------

    def construir_ydl_opts(
        self,
        formato_salida,
        carpeta_destino,
        tiempo_inicio,
        texto_video,
        texto_mp3,
        item
    ):

        opts = {

            "outtmpl": os.path.join(
                carpeta_destino,
                "%(title)s.%(ext)s"
            ),

            "progress_hooks": [
                lambda d:
                self.hook_progreso(
                    d,
                    item
                )
            ],

            "ffmpeg_location":
                FFMPEG_LOCATION,

            "socket_timeout": 30,

            "retries": 10,

            "fragment_retries": 10,

            "extractor_retries": 3,

            "continuedl": True,

            "overwrites": False,

            "quiet": False,

            "no_warnings": False,
        }

        # ----------------------------------------------------
        # CORTE
        # ----------------------------------------------------

        if tiempo_inicio is not None:

            opts[
                "download_sections"
            ] = [
                f"*{tiempo_inicio}-"
            ]

            opts[
                "force_keyframes_at_cuts"
            ] = True

        # ----------------------------------------------------
        # CALIDAD VÍDEO
        # ----------------------------------------------------

        altura_max = None

        for texto, altura in (
            VIDEO_CALIDADES_MAX
        ):

            if texto == texto_video:

                altura_max = altura

                break

        # ----------------------------------------------------
        # BITRATE MP3
        # ----------------------------------------------------

        br_max = None

        for texto, bitrate in (
            MP3_BITRATES_MAX
        ):

            if texto == texto_mp3:

                br_max = bitrate

                break

        # ----------------------------------------------------
        # VÍDEO
        # ----------------------------------------------------

        if formato_salida in [
            "Original",
            "MP4",
            "MKV",
            "WEBM"
        ]:

            if altura_max is None:

                video_fmt = (
                    "bestvideo+bestaudio/"
                    "best"
                )

            else:

                video_fmt = (
                    f"bestvideo[height<={altura_max}]"
                    "+bestaudio/"
                    "best"
                )

            opts[
                "format"
            ] = video_fmt

            if formato_salida != "Original":

                opts[
                    "merge_output_format"
                ] = (
                    formato_salida.lower()
                )

        # ----------------------------------------------------
        # AUDIO
        # ----------------------------------------------------

        elif formato_salida in [
            "MP3",
            "WAV",
            "AAC",
            "OGG",
            "FLAC"
        ]:

            codec = (
                formato_salida.lower()
            )

            opts[
                "format"
            ] = "bestaudio/best"

            post = {

                "key":
                    "FFmpegExtractAudio",

                "preferredcodec":
                    codec,
            }

            if formato_salida == "MP3":

                if br_max is not None:

                    post[
                        "preferredquality"
                    ] = str(
                        br_max
                    )

                else:

                    post[
                        "preferredquality"
                    ] = "192"

            opts[
                "postprocessors"
            ] = [
                post
            ]

        return opts

    # --------------------------------------------------------
    # HISTORIAL
    # --------------------------------------------------------

    def crear_item_historial(
        self,
        titulo,
        formato,
        carpeta_destino
    ):

        item = DownloadItem(
            self.scroll_historial,
            titulo,
            formato,
            carpeta_destino
        )

        filas = len(
            self.scroll_historial
            .winfo_children()
        )

        item.grid(
            row=filas,
            column=0,
            sticky="ew",
            padx=5,
            pady=5
        )

        self.scroll_historial.update_idletasks()

        try:

            self.scroll_historial._parent_canvas.yview_moveto(
                1.0
            )

        except Exception:

            pass

        return item

    # --------------------------------------------------------
    # DESCARGAR
    # --------------------------------------------------------

    def descargar(
        self
    ):

        if self.descargando:

            messagebox.showwarning(
                "Aviso",
                "Ya hay una descarga en curso."
            )

            return

        url = (
            self.entry_url
            .get()
            .strip()
        )

        carpeta_destino = (
            self.entry_carpeta
            .get()
            .strip()
        )

        formato_salida = (
            self.combo_formato
            .get()
        )

        tiempo_inicio = (
            self.tiempo_inicio
        )

        texto_video = (
            self.combo_video_quality
            .get()
        )

        texto_mp3 = (
            self.combo_mp3_bitrate
            .get()
        )

        if not url:

            messagebox.showwarning(
                "Aviso",
                "Introduce una URL."
            )

            return

        if not es_url_youtube(
            url
        ):

            messagebox.showwarning(
                "Aviso",
                "La URL no pertenece a YouTube."
            )

            return

        if (
            not carpeta_destino
            or not os.path.isdir(
                carpeta_destino
            )
        ):

            messagebox.showwarning(
                "Aviso",
                "Selecciona una carpeta válida."
            )

            return

        self.carpeta_destino = (
            carpeta_destino
        )

        guardar_carpeta(
            carpeta_destino
        )

        # ----------------------------------------------------
        # FFMPEG
        # ----------------------------------------------------

        ffmpeg_exe = os.path.join(
            FFMPEG_LOCATION,
            "ffmpeg.exe"
        )

        ffprobe_exe = os.path.join(
            FFMPEG_LOCATION,
            "ffprobe.exe"
        )

        if not os.path.isfile(
            ffmpeg_exe
        ):

            messagebox.showerror(
                "FFmpeg no encontrado",
                (
                    "No se ha encontrado "
                    "ffmpeg.exe en:\n"
                    f"{FFMPEG_LOCATION}"
                )
            )

            return

        if not os.path.isfile(
            ffprobe_exe
        ):

            messagebox.showerror(
                "FFprobe no encontrado",
                (
                    "No se ha encontrado "
                    "ffprobe.exe en:\n"
                    f"{FFMPEG_LOCATION}"
                )
            )

            return

        # ----------------------------------------------------
        # PROGRESO
        # ----------------------------------------------------

        self.progress_global.set(
            0
        )

        self.label_progreso_global.configure(
            text="0%"
        )

        self.update_idletasks()

        self.descargando = True

        self.btn_descargar.configure(
            state="disabled"
        )

        threading.Thread(
            target=self.descargar_thread,
            args=(
                url,
                formato_salida,
                carpeta_destino,
                tiempo_inicio,
                texto_video,
                texto_mp3
            ),
            daemon=True
        ).start()

    # --------------------------------------------------------
    # HILO DE DESCARGA
    # --------------------------------------------------------

    def descargar_thread(
        self,
        url,
        formato_salida,
        carpeta_destino,
        tiempo_inicio,
        texto_video,
        texto_mp3
    ):

        item = None

        try:

            # ------------------------------------------------
            # INFORMACIÓN
            # ------------------------------------------------

            info_opts = {

                "quiet": True,

                "skip_download": True,

                "ffmpeg_location":
                    FFMPEG_LOCATION,

                "socket_timeout": 30,

                "retries": 5,

                "extractor_retries": 3,
            }

            with yt_dlp.YoutubeDL(
                info_opts
            ) as ydl_info:

                info = (
                    ydl_info.extract_info(
                        url,
                        download=False
                    )
                )

            titulo = info.get(
                "title",
                "Desconocido"
            )

            # ------------------------------------------------
            # CREAR ITEM TKINTER
            # ------------------------------------------------

            evento = threading.Event()

            def crear_item():

                nonlocal item

                item = (
                    self.crear_item_historial(
                        titulo,
                        formato_salida,
                        carpeta_destino
                    )
                )

                self.current_item = item

                evento.set()

            self.after(
                0,
                crear_item
            )

            evento.wait(
                timeout=5
            )

            if item is None:

                raise RuntimeError(
                    "No se pudo crear el elemento "
                    "del historial."
                )

            # ------------------------------------------------
            # OPCIONES
            # ------------------------------------------------

            ydl_opts = (
                self.construir_ydl_opts(
                    formato_salida,
                    carpeta_destino,
                    tiempo_inicio,
                    texto_video,
                    texto_mp3,
                    item
                )
            )

            print()
            print(
                "=" * 70
            )
            print(
                "INICIANDO DESCARGA"
            )
            print(
                f"URL: {url}"
            )
            print(
                f"Título: {titulo}"
            )
            print(
                f"Formato: {formato_salida}"
            )
            print(
                f"Destino: {carpeta_destino}"
            )

            if tiempo_inicio is not None:

                print(
                    "Inicio:",
                    tiempo_inicio,
                    "segundos"
                )

            print(
                "=" * 70
            )
            print()

            # ------------------------------------------------
            # DESCARGA
            # ------------------------------------------------

            with yt_dlp.YoutubeDL(
                ydl_opts
            ) as ydl:

                info_final = (
                    ydl.extract_info(
                        url,
                        download=True
                    )
                )

            # ------------------------------------------------
            # LOCALIZAR ARCHIVO
            # ------------------------------------------------

            archivo_final = (
                self.buscar_archivo_descargado(
                    titulo,
                    formato_salida,
                    carpeta_destino
                )
            )

            if archivo_final is None:

                try:

                    with yt_dlp.YoutubeDL({

                        "outtmpl": os.path.join(
                            carpeta_destino,
                            "%(title)s.%(ext)s"
                        )

                    }) as ydl_tmp:

                        posible = (
                            ydl_tmp.prepare_filename(
                                info_final
                            )
                        )

                    if os.path.isfile(
                        posible
                    ):

                        archivo_final = (
                            posible
                        )

                except Exception:

                    pass

            if archivo_final is None:

                raise RuntimeError(
                    "La descarga ha terminado, "
                    "pero no se ha podido localizar "
                    "el archivo final."
                )

            archivo_final = os.path.abspath(
                archivo_final
            )

            # ------------------------------------------------
            # COMPLETADO
            # ------------------------------------------------

            self.after(
                0,
                item.marcar_completado,
                archivo_final
            )

            self.after(
                0,
                self.marcar_progreso_global_completado
            )

            print()
            print(
                "DESCARGA COMPLETADA:"
            )

            print(
                archivo_final
            )

            print()

        except DownloadError as e:

            error_msg = (
                self.obtener_error_detallado(
                    e
                )
            )

            print()
            print(
                "=" * 70
            )
            print(
                "ERROR YT-DLP"
            )
            print(
                "=" * 70
            )

            print(
                "Tipo:",
                type(e).__name__
            )

            print(
                "Error:",
                repr(e)
            )

            print(
                "Mensaje:",
                error_msg
            )

            traceback.print_exc()

            print(
                "=" * 70
            )
            print()

            self.after(
                0,
                self.mostrar_error_descarga,
                item,
                error_msg
            )

        except Exception as e:

            error_msg = (
                self.obtener_error_detallado(
                    e
                )
            )

            print()
            print(
                "=" * 70
            )
            print(
                "ERROR DURANTE LA DESCARGA"
            )
            print(
                "=" * 70
            )

            print(
                "Tipo:",
                type(e).__name__
            )

            print(
                "Error:",
                repr(e)
            )

            print(
                "Mensaje:",
                error_msg
            )

            traceback.print_exc()

            print(
                "=" * 70
            )
            print()

            self.after(
                0,
                self.mostrar_error_descarga,
                item,
                error_msg
            )

        finally:

            self.after(
                0,
                self.finalizar_descarga
            )

    # --------------------------------------------------------
    # PROGRESO GLOBAL COMPLETADO
    # --------------------------------------------------------

    def marcar_progreso_global_completado(
        self
    ):

        self.progress_global.set(
            1.0
        )

        self.label_progreso_global.configure(
            text="Completado"
        )

    # --------------------------------------------------------
    # ERROR DETALLADO
    # --------------------------------------------------------

    def obtener_error_detallado(
        self,
        error
    ):

        mensajes = []

        # ----------------------------------------------------
        # str()
        # ----------------------------------------------------

        try:

            texto = str(
                error
            ).strip()

            if (
                texto
                and texto.lower() != "none"
            ):

                mensajes.append(
                    texto
                )

        except Exception:

            pass

        # ----------------------------------------------------
        # .msg
        # ----------------------------------------------------

        try:

            msg = getattr(
                error,
                "msg",
                None
            )

            if msg:

                msg = str(
                    msg
                ).strip()

                if (
                    msg
                    and msg.lower() != "none"
                    and msg not in mensajes
                ):

                    mensajes.append(
                        msg
                    )

        except Exception:

            pass

        # ----------------------------------------------------
        # args
        # ----------------------------------------------------

        try:

            if error.args:

                for arg in error.args:

                    if arg is None:
                        continue

                    texto = str(
                        arg
                    ).strip()

                    if (
                        texto
                        and texto.lower() != "none"
                        and texto not in mensajes
                    ):

                        mensajes.append(
                            texto
                        )

        except Exception:

            pass

        # ----------------------------------------------------
        # RESULTADO
        # ----------------------------------------------------

        if mensajes:

            resultado = "\n".join(
                mensajes
            )

        else:

            resultado = repr(
                error
            )

        # ----------------------------------------------------
        # TIMEOUT
        # ----------------------------------------------------

        if (
            "timed out"
            in resultado.lower()
        ):

            resultado = (
                "La conexión ha expirado. "
                "Comprueba tu conexión a Internet."
            )

        return resultado

    # --------------------------------------------------------
    # ERROR DE DESCARGA
    # --------------------------------------------------------

    def mostrar_error_descarga(
        self,
        item,
        mensaje
    ):

        if not mensaje:

            mensaje = (
                "Error desconocido."
            )

        if item is not None:

            item.marcar_error(
                mensaje
            )

        messagebox.showerror(
            "Error durante la descarga",
            mensaje
        )

    # --------------------------------------------------------
    # FINALIZAR DESCARGA
    # --------------------------------------------------------

    def finalizar_descarga(
        self
    ):

        item = self.current_item

        # ----------------------------------------------------
        # SI HA TERMINADO CORRECTAMENTE, NOS ASEGURAMOS DE
        # QUE LA BARRA GLOBAL NO SE QUEDE EN "PROCESANDO…".
        # ----------------------------------------------------

        if (
            item is not None
            and item.finalizado
            and not item.error
        ):

            self.progress_global.set(
                1.0
            )

            self.label_progreso_global.configure(
                text="Completado"
            )

        self.current_item = None

        self.descargando = False

        self.btn_descargar.configure(
            state="normal"
        )

    # --------------------------------------------------------
    # BUSCAR ARCHIVO FINAL
    # --------------------------------------------------------

    def buscar_archivo_descargado(
        self,
        titulo,
        formato,
        carpeta_destino
    ):

        extensiones = {

            "MP4": [
                ".mp4"
            ],

            "MKV": [
                ".mkv"
            ],

            "WEBM": [
                ".webm"
            ],

            "MP3": [
                ".mp3"
            ],

            "WAV": [
                ".wav"
            ],

            "AAC": [
                ".aac",
                ".m4a"
            ],

            "OGG": [
                ".ogg",
                ".opus"
            ],

            "FLAC": [
                ".flac"
            ],

            "Original": [
                ".mp4",
                ".mkv",
                ".webm",
                ".mov",
                ".avi",
                ".m4a",
                ".mp3",
                ".opus",
                ".ogg",
                ".flac",
                ".wav"
            ]
        }

        extensiones_busqueda = (
            extensiones.get(
                formato,
                []
            )
        )

        candidatos = []

        try:

            for nombre in os.listdir(
                carpeta_destino
            ):

                ruta = os.path.join(
                    carpeta_destino,
                    nombre
                )

                if not os.path.isfile(
                    ruta
                ):

                    continue

                extension = (
                    os.path.splitext(
                        nombre
                    )[1].lower()
                )

                if (
                    extension
                    not in extensiones_busqueda
                ):

                    continue

                candidatos.append(
                    ruta
                )

        except Exception:

            return None

        if not candidatos:

            return None

        # ----------------------------------------------------
        # MÁS RECIENTE
        # ----------------------------------------------------

        candidatos.sort(
            key=lambda x:
            os.path.getmtime(x),
            reverse=True
        )

        return candidatos[0]


# ------------------------------------------------------------
# MAIN
# ------------------------------------------------------------

if __name__ == "__main__":

    app = YouTubeDownloaderApp()

    app.mainloop()