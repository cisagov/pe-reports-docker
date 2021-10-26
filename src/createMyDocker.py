#!/usr/bin/python3
"""A tool for docker creation and running of the associated container."""
# Standard Python Libraries
import logging
import os  # nosec
from typing import Optional

# Third-Party Libraries
# Third Party Libraries
import docker

dockerName = "DevEnv"
imageName = "pe-dev-environment1"


def is_container_running(container_name: str, image_name: str) -> Optional[bool]:
    """Verify the status of a container and associated image. If no image or a container present then create the image and container by name.

    :param container_name: the name of the container
    :return: boolean or None
    """
    RUNNING = "running"
    # Connect to Docker using the default socket or the configuration
    # in your environment
    docker_client = docker.from_env()

    container = docker_client.containers.get(container_name)
    container_state = container.attrs["State"]

    try:
        image = docker_client.images.get(image_name)

        if image:
            # print(f'The image {image} exists')
            logging.info("The image exists no further action to be taken")
            # If continer exists
            if container and container_state["Status"] == RUNNING:
                # print(f'The container is running!! The container name is {container}')
                logging.info(
                    f"The container is running!! The container name is {dockerName} "
                )
            else:
                # print(f'The image exists and Starting the container {container} now...')
                logging.info(
                    f"The image exists and the container {imageName} is starting now..."
                )
                # print(f'The image exists and Starting the container {container} now...')
                os.system(f"docker start {dockerName}")  # nosec

    except docker.errors.ImageNotFound as exc:
        logging.info(
            f"Check container name. Container name not found! \n{exc.explanation}"
        )
        createNewImage()

    return container_state["Status"] == RUNNING


def createNewImage():
    """Take user input if "Y" and create a new container."""
    userAnswer = input(f"Would you like to create a new container named {imageName}? ")
    if userAnswer == "Y":
        logging.info(f"Creating {imageName} image now")
        os.system(  # nosec
            f"docker build --no-cache -t pe-dev-environment . && docker run -t -i -h {imageName} --name {dockerName}"
            f" --mount type=bind,src=/Users/duhnc/Desktop/allInfo/pe-reports-docker/env,dst=/run/env {imageName} bash "
        )
    else:
        pass


def main():
    """Set up logging and check for image and if associated container is running."""
    logging.basicConfig(format="%(asctime)-15s %(levelname)s %(message)s", level="INFO")

    is_container_running(dockerName, imageName)


if __name__ == "__main__":
    main()
