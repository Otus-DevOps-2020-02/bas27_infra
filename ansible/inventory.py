#!/usr/bin/env python

import argparse
import os
import sys

try:
    import json
except ImportError:
    import simplejson as json

class CustomInventory:
    def __init__(self):
        self.inventory = {}
        self.read_cli_args()

        if self.args.list:
            self.inventory = self.our_inventory()
        else:
            self.inventory = self.emty_inventory()
        print json.dumps(self.inventory)

    def emty_inventory(self):
        return {"_meta":{"hostvars":{}}}

    def our_inventory(self):
        return {
                "group" : {
                        "hosts":['reddit-app','reddit-db'],
                        "vars":{"variable":"Test1"}
                },
                "_meta":{
                        "hostvars": {"host_var":"Test2"}
                }
        }
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action="store_true")
        self.args = parser.parse_args()
CustomInventory()
