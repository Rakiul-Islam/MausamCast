import subprocess, os

def run_java_program(city_name):
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

    """present_dir = os.getcwd() #.replace("\\", "//")
        parent_of_present_dir =
        
        with open(r"./ps_script/run_java_code_base.ps1", "r") as base_ps_file:
            base_script = base_ps_file.read()
            base_ps_file.flush()
        
        final_string = base_script + " \"" + city_name.lower() + "\""
        
        with open(r"./ps_script/run_java_code_final.ps1", "w") as final_ps_file:
            final_ps_file.write(final_string)
        
        print("Executing the java program using Shell--------------------------------------------------")
        
        p = subprocess.Popen(["powershell.exe", present_dir + "//ps_script//run_java_code_final.ps1"], stdout=sys.stdout)
        p.communicate()
        
        print("End of output of the java program using Shell---------------------------------------------------------------")"""

    return code

if __name__ == "__main__":
    code =  run_java_program("chennai")