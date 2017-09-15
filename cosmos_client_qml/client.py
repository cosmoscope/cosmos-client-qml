import gevent
from zerorpc import Subscriber, Client

from .hub import *


# from cosmoscope.core.spectra import Spectrum1D


class ClientAPI(Subscriber):
    def __init__(self, client_ip, *args, **kwargs):
        super(ClientAPI, self).__init__(*args, **kwargs)

        # Setup pusher
        self.client = Client()
        self.client.bind(client_ip)

        # Connect to message hub
        self._hub = Hub()

        self._hub.subscribe(LoadDataMessage, self.client.load_data, self)

    def data_loaded(self, data):
        import msgpack

        unpacked_data = msgpack.unpackb(data, object_hook=Spectrum1D.decode)

        self._hub.publish(AddDataMessage, unpacked_data)

    def data_unloaded(self, data):
        pass


def start(server_ip=None, client_ip=None):
    logging.info("[client] Starting services...")

    server_ip = server_ip or "ipc://127.0.0.1:4242"
    client_ip = client_ip or "ipc://127.0.0.1:4243"

    # Setup the pull service
    client = ClientAPI(client_ip)
    client.connect(server_ip)

    gevent.spawn(client.run)

    logging.info(
        "[client] Client is now sending on {} and listening on {}.".format(
            client_ip, server_ip))