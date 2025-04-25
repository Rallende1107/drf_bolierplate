FROM python:3.13.3

# Instalar Cliente SSH
RUN apt-get update && apt-get install -y openssh-client

# Definir variable de entorno
ENV PYTHONUNBUFFERED=1
# PYTHONUNBUFFERED debe escribirse así, con "ED" al final y con el símbolo =

# Establecer directorio de trabajo
WORKDIR /app

# # Clonar el repositorio (puede ser público o privado con claves)
# RUN git clone https://github.com/usuario/proyecto-django.git .

# Copiar requerimientos
COPY requirements.txt .

# Instalar requerimientos
RUN pip install --no-cache-dir -r requirements.txt

# Copiar la aplicacion al directorio de trabajo
COPY . /app

# Ejecutar collectstatic (modo no interactivo)
RUN python manage.py collectstatic --noinput

# Comando por defecto
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
