import os
import sys
import csv
import pandas as pd


def get_last_level_folders(path):
    if not os.path.exists(path) or not os.path.isdir(path):
        print("Invalid folder path.")
        return None

    current_path = os.path.abspath(path)
    folders = []

    for root, dirnames, filenames in os.walk(current_path):
        for dirname in dirnames:
            folder_path = os.path.join(root, dirname)
            if not any(os.path.isdir(os.path.join(folder_path, subfolder)) for subfolder in os.listdir(folder_path)):
                folders.append((folder_path, os.path.basename(folder_path)))
    
    return folders

def write_csv(folder_path):
    result_non = "ResultFornon-SEV.output"
    result_sev = "ResultForSEV.output"
    data = []

    for folder_info in folder_path:
        folder_name = folder_info[1]
        folder_route = folder_info[0]

        try:
            original_data = []
            df = pd.read_csv(folder_route + "/" + result_non, header=None)
            df = df.apply(pd.to_numeric, errors='coerce')
            original_data.extend(df.values.flatten().tolist())
            mean_value = df.mean().values.item()
            data.append(['non-SEV', folder_name,  mean_value])
            data.append(original_data)

            original_data = []
            df = pd.read_csv(folder_route + "/" + result_sev, header=None)
            df = df.apply(pd.to_numeric, errors='coerce')
            original_data.extend(df.values.flatten().tolist())
            mean_value = df.mean().values.item()
            data.append(['SEV', folder_name, mean_value])
            data.append(original_data)
        except Exception as e:
            print(e)
            return None

    csv_file = 'data.csv'
    with open(csv_file, 'w') as file:
        writer = csv.writer(file)
        writer.writerows(data)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <folder_path>")
    else:
        folder_path = sys.argv[1]
        last_level_folders = get_last_level_folders(folder_path)
        
        write_csv(last_level_folders)
