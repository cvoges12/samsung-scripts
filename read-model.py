import serial
import time

ser = serial.Serial("/dev/ttyACM0", baudrate=115200)
time.sleep(0.5)

# To read the response
out_raw = ser.read_all()

ser.write("AT+GMM\r\n".encode())

time.sleep(0.5)
print(ser.read_all().replace(b'\r\n', b'\n').decode("utf-8"))
