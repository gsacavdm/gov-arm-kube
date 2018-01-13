import sys
import base64

with file('secret.template.yaml') as f:
  c = f.read()
  c = c.replace('<replaceSecret1>', base64.encodestring(sys.argv[1]))

with file('tmp/secret.yaml', 'w') as f:
  f.write(c)
