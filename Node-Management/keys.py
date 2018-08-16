from os import urandom
from ethereum import utils


f = open('keys.txt', 'a')
private_key = utils.sha3(urandom(4096))
raw_address = utils.privtoaddr(private_key)
account_addr = utils.checksum_encode(raw_address)
line='{}\t{}\n'.format(account_addr, private_key.hex())
f.write(line)
f.close()
print(line)
