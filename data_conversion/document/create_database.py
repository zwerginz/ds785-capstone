from pymongo import MongoClient
import pymongo

def create_database():
    CONNECTION_STRING = ""

    from pymongo import MongoClient
    client = MongoClient(CONNECTION_STRING)
    
    if 'AdventureWorksDocument' not in client.list_database_names():
        collection_name = client['AdventureWorksDocument']["orders"]
        item_1 = {
            "first": "item"
            }

        collection_name.insert_one(item_1)

    
if __name__ == "__main__":    
    
    create_database()