import zipfile
import time
from pathlib import Path


def upload_to_base():
    if zipfile.is_zipfile('xml.zip'):
        z = zipfile.ZipFile('xml.zip', 'r')
        z.extractall()

my_file = Path("xml.zip")
if my_file.is_file():
    upload_to_base()
    time.sleep(300)
