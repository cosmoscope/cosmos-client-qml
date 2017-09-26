import logging

import gevent
from zerorpc import Client, Subscriber

from .hub import *


class SubscriberAPI(Subscriber):
    def __init__(self, client_ip, *args, **kwargs):
        super(SubscriberAPI, self).__init__(*args, **kwargs)

        # Setup pusher
        self.client = Client()
        self.client.connect(client_ip)

        # Connect to message hub
        self._hub = Hub()

        self._hub.subscribe(LoadDataMessage, self.client.load_data, self)

    def data_loaded(self, data):
        import msgpack

        unpacked_data = msgpack.unpackb(data)

        self._hub.publish(AddDataMessage, unpacked_data)

    def data_unloaded(self, data):
        pass


def launch(server_ip=None, client_ip=None):
    logging.info("[client] Starting services...")

    server_ip = server_ip or "ipc://127.0.0.1:4242"
    client_ip = client_ip or "ipc://127.0.0.1:4243"

    # Setup the pull service
    subscriber = SubscriberAPI(client_ip)
    subscriber.connect(server_ip)

    gevent.spawn(subscriber.run)

    logging.info(
        "[client] Client is now sending on {} and listening on {}.".format(
            client_ip, server_ip))

    # Attempt testing whether fuction was added to server object
    subscriber.client.load_data_from_path('/home/nmearl/Downloads/Transcript.txt', '*')
