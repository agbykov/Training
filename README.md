# Training
## Terraform training 
### test

username: **admin**

password: **secret**

**Note:** To enable Authentication again after success login clear the browser cache.

## Commands for deployment Flask application

    sudo apt update
    sudo apt -y install python3 python3-venv python3-dev

    cd ~/webservice
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt

    export FLASK_APP=webservice.py
    echo "export FLASK_APP=webservice.py" >> ~/.profile

## Commands for run Flask application on port 80    
    sudo ~/webservice/venv/bin/flask run --port=80