# ---- Etapa 1: Build ----
# Imagen base ligera de Node (Alpine) usada solo para instalar dependencias y compilar el proyecto.
FROM node:22-alpine AS build

# Establece el directorio de trabajo dentro del contenedor; los comandos siguientes se ejecutan aquí.
WORKDIR /app

# Habilita corepack, que permite usar pnpm sin instalarlo manualmente.
RUN corepack enable

# Copia primero solo los archivos de dependencias (no todo el código).
# Esto aprovecha la cache de Docker: si estos archivos no cambian, no se reinstalan dependencias en cada build.
COPY package.json pnpm-lock.yaml ./

# Instala las dependencias exactamente como en pnpm-lock.yaml (reproducible y más rápido).
RUN pnpm install --frozen-lockfile

# Copia el resto del código fuente del proyecto al contenedor.
COPY . .

# Ejecuta el script "build" definido en package.json (vite build), generando los archivos estáticos en /app/dist.
RUN pnpm build

# ---- Etapa 2: Producción ----
# Imagen final, mucho más liviana, que solo sirve los archivos estáticos generados.
FROM nginx:alpine AS production

# Copia únicamente el resultado del build (carpeta dist) desde la etapa "build" hacia la carpeta pública de Nginx.
# Así la imagen final no contiene node_modules ni herramientas de compilación, solo el sitio ya compilado.
COPY --from=build /app/dist /usr/share/nginx/html

# Documenta que el contenedor escuchará en el puerto 80 (el puerto por defecto de Nginx).
EXPOSE 80

# Comando que se ejecuta al iniciar el contenedor: arranca Nginx en primer plano
# (necesario para que Docker mantenga el proceso vivo y el contenedor no se cierre).
CMD ["nginx", "-g", "daemon off;"]
