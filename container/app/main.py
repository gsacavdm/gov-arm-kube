from flask import Flask
app = Flask(__name__)

import os

@app.route("/")
def main():
  secretEnviron = os.getenv('secret')
  
  secretFile = '/secrets/secret'
  secretVol = ''
  if os.path.exists(secretFile):
    with file(secretFile) as f:
      secretVol = f.readline() 
  
  returnString = "The Secret Vault<br/>"
  returnString += "<b>Secret from environment variable</b> (secret): %s<br/>" % secretEnviron 
  returnString += "<b>Secret from volume</b> (/secrets/secret): %s" % secretVol

  return returnString

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')