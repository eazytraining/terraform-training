# INSTALLATION DE TERRAFORM DANS CENTOS

### Installer unzip
```bash
sudo yum install unzip
```

### Télécharger la dernière version de terraform (en remplaçant le numéro de version plus récent si nécessaire)
```bash
wget https://releases.hashicorp.com/terraform/1.7.2/terraform_1.7.2_linux_amd64.zip
```

### Extraire l’archive de fichiers téléchargés
```bash
unzip terraform_1.7.2_linux_amd64.zip
```

### Déplacer l’exécutable dans un répertoire de recherche d’exécutables
```bash
sudo mv terraform /usr/local/bin/
```

### Exécutez-le
```bash
terraform --version 
```