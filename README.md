# EmilMind_microservices
EmilMind microservices repository

## Docker-2
В процессе сделано:
 - Основное задание:
    - Создание docker host
    - Создание своего образа
    - Работа с Docker Hub
 - Задание *1:
	- Сравние вывода команд (ответ в docker-monolith/docker-1.log): 
        ~~~bash
        docker inspect <u_container_id> и docker inspect <u_image_id>        
        ~~~
 - Задание *2:
    - Автоматизировал поднятие нескольких инстансов в Yandex Cloud, установку на них докера и запуск там образа freezy503/otus-reddit:1.0

    - Автоматизация поднятия нескольких инстансов в Yandex Cloud, установка на них Docker и запуск образа /otus-reddit:1.0
        - Terraform
        ~~~bash
        cd docker-monolith/infra/terraform terraform && terraform init && terraform apply -auto-approve
        ~~~

         - Ansible
        ~~~bash
        ansible-playbook -i environments/stage/inventory playbooks/main.yml
        ~~~

        - Packer
        ~~~bash
        cd docker-monolith/infra/packer && packer build --var-file=variables.json reddit_in_docker.json 
        ~~~
