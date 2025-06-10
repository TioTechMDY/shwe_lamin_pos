First Login to the server with this command
```bash
ssh -i ~/.ssh/id_rsa root@<server-ip>
```

Then run the following commands to install the required packages
```bash
sudo apt update && apt install -y git curl wget && sudo apt install -y docker.io docker-compose
```
After that, clone the repository with prod branch
```bash
git clone https://github.com/TioTechMDY/shwe_lamin_pos.git 
cd shwe_lamin_pos
git checkout prod
```


Copy with this command to create a `.env` file from env.example 
```bash
cp env.example .env
```

To edit the `.env` file, you can use a text editor like `nano` or `vim`. For example:
```bash
 nano .env
```
Then Ctrl + O to save and Enter and Ctrl + X to exit.

Then go to application directory
```bash
cd application
```

Copy with this command to create a `.env` file from env.example
```bash
cp env.example .env
```

Change the database connection settings in the `.env` file to match your database configuration. 
That need to equal to the database connection settings in the `.env` file in the root directory.
```bash
nano .env
```

Then run docker compose to start the application
```bash
docker-compose up -d
rm -rf db-data
```

Finally, you can access the application by navigating to `http://<server-ip>:8080` in your web browser.

