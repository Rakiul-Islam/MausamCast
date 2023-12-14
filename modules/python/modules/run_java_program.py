import subprocess, os

def run_java_program(city_name):
    # thia function will run the java program and return the code
    code = 1 # error code 0 = ok, 1 = fail
    current_directory = os.getcwd()
    base_script = f"cd '{current_directory}\\modules\\java\\scrapper'; java -cp \".;jsoup.jar;mysql-connector-j.jar\" Main"
    final_script = base_script + " \"" + city_name.lower() + "\""
    p = subprocess.run(["powershell", "-Command", final_script], capture_output=True)
    print(f"Output after Executing the java program using Shell---------------------------------------------------------")
    if "Database updating : Successful" in p.stdout.decode():
        code = 0
    elif "Database updating : Failed" in p.stdout.decode():
        code = 1
    print(p.stdout.decode(), end="")
    print(f"code = {code}")
    print(f"End of output of the java program --------------------------------------------------------------------------")

    return code

if __name__ == "__main__":
    code =  run_java_program("chennai")