#!/usr/bin/python3
from crypto.Cipher import AES # import the crypto functionality needed

with open('note.enc','rb') as f: # read the encrypted file; call its data cipher_text
  cipher_text = f.read()
for i in range(0,255): # run 255 times with i of 00, 01, 02...
    plain_text = '' # start with empty string for plaint_text
    # set up decryption with this value of i
    decr = AES.new(bytes.fromhex("{:02x}".format(i)+'00'*31), AES.MODE_CBC, bytes.fromhex('00'*16))
    plain_text = decr.decrypt(cipher_text) # do the decryption
    if (b'stop' in plain_text): print(str(plain_text,'utf8')) # search for "stop" in the result

# As written, it runs but no output
# If you remove the 'if' portion it throws an error wher utf cannot convert a hex value.

# Things I have tried:
  # import codecs
  # if (b'stop' in plain_text): print(plain_text.decode("utf-8", "ignore"))

# Other useful links
  # https://wiki.openssl.org/index.php/Enc
  # https://pycryptodome.readthedocs.io/en/latest/src/cipher/cipher.html