# Importer une infrastructure existante avec terraform apply

Rappel : Terraform peut importer l'infrastructure existante. Cela vous permet de récupérer les ressources que vous avez créées par d'autres moyens et de les gérer sous Terraform.

##### Etude de cas :  Importation d'une instance EC2 AWS

1. Identifiez l'infrastructure à importer ;

2. Récupérez les configurations l’infrastructure ;

3. Déclarez l'importation ;

4. Déclarez la ressource (Important : Définir tous les arguments nécessaires, sinon l'infrastructure sera mise à jour lors du apply) correspondante à l'infrastructure à importer dans notre cas EC2 ;

5. Taper la commande terraform plan :  si le plan contient à la fois « import » et « change », vérifiez la définition des arguments ;

6. Taper la commande terraform apply --auto-approve
