FROM python:3.12-slim
RUN useradd -m appuser
WORKDIR /app
COPY app/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ /app/
USER appuser
EXPOSE 8080
CMD ["python","app.py"]
