#!/usr/bin/env python

import sys, subprocess, glob, os, re

def createDir(directory):
    if os.path.exists(directory):
        sys.exit("Error: Directory already exists !")
    else:
        os.makedirs(directory)
    return

def replaceModuleName (directory, pattern, replace):
    print "Cooking files in" , directory
    for fname in os.listdir(directory):
        if fname.endswith(".swift"):
            original_file = os.path.join(directory, fname)
            text = open (original_file ).read()
            if pattern in text:
                 open ( original_file, 'w').write( text.replace( pattern, replace ) )
            new_fname = re.sub(pattern, replace, fname)
            new_file = os.path.join(directory, new_fname)
            os.rename(original_file, new_file)
    return


module_name = raw_input('Enter Module Name: ')

source_dir = '../Source/EndPoints/' + module_name
test_dir = '../Tests/EndPointsTests/' + module_name

createDir(source_dir)
createDir(test_dir)

subprocess.call(['cp', '-rf', 'Templates/Source/', source_dir])
subprocess.call(['cp', '-rf', 'Templates/Test/', test_dir])


pattern = '{{MODULENAME}}'
replaceModuleName(test_dir, pattern, module_name)
replaceModuleName(source_dir, pattern,  module_name)

subprocess.call(['open', source_dir])
subprocess.call(['open', test_dir])

print "Success: Templates successfully generated! Drag them to xcode project to work on them."

