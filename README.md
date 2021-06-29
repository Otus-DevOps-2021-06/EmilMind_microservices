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
    - Автоматизация поднятия нескольких инстансов в Yandex Cloud, установка на них Docker и запуск образа emilmind/otus-reddit:1.0
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


## Docker-3
В процессе сделано:
 - Основное задание:
    - Научиться описывать и собирать Docker-образы для сервисного приложения
    - Научиться оптимизировать работу с Docker-образами (оптимизирован образ ui:2.0)
    - Запуск и работа приложения на основе Docker-образов (созадние сети и использование volume)


- Задание *1:
    - Запуск контейнеров с другими сетевыми алиасами: адреса для взаимодействия контейнеров определены через ENV-переменные
    ~~~bash
    docker run -d --network=reddit --network-alias=post_db_new --network-alias=comment_db_new mongo:latest
    docker run -d --network=reddit --network-alias=posts_new --env POST_DATABASE_HOST=post_db_new --env POST_DATABASE=posts_new emilmind/post:1.0
    docker run -d --network=reddit --network-alias=comment_new --env COMMENT_DATABASE_HOST=comment_db_new --env COMMENT_DATABASE=comments_new emilmind/comment:1.0
    docker run -d --network=reddit --env POST_SERVICE_HOST=posts_new --env COMMENT_SERVICE_HOST=comment_new -p 9292:9292 emilmind/ui:1.0
    ~~~
- Задание *2:
    - Для образа UI был переделан Dockerfile на основе ruby:2.7-alpine
    ~~~bash
    docker build -t emilmind/ui:2.0 ./ui/ -f ./ui/Dockerfile.1 
    ~~~
    - Запуск контейнеров
    ~~~bash
    docker network create reddit    
    docker volume create reddit_db
    docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
    docker run -d --network=reddit --network-alias=post emilmind/post:1.0
    docker run -d --network=reddit --network-alias=comment emilmind/comment:1.0
    docker run -d --network=reddit -p 9292:9292 emilmind/ui:2.0
    ~~~