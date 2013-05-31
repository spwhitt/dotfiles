#!/usr/bin/python

import i3, sys
from subprocess import Popen, PIPE

# Global dmenu appearance
G_DMENU = [ '-i', '-fn', 'Inconsolata-14' ]

CMDS = {}
def command(fun):
    CMDS[fun.__name__] = fun

def run_dmenu(input_list, dmenu_args=[]):

    # TODO: Check dmenu's exit code, quit if dmenu did not select something
    # Alternately, check if string is empty
    p = Popen(["dmenu"]+G_DMENU+dmenu_args, stdin=PIPE, stdout=PIPE)
    return p.communicate(input=input_list)[0]

def clean_title(title):
    return title.encode('ascii', 'ignore').strip()

@command
def window_do():
    """Present a list of windows. Perform specified action on the selected one"""
    # Get all unfocused windows
    uwin = i3.filter(nodes=[], focused=False)
    # Dictionary of window titles to window ids
    window_dict = {clean_title(w['name']): w['id'] for w in uwin if w['window']}
    # Newline separated list of window titles
    title_list = '\n'.join(window_dict.keys())
    # Run dmenu
    selection = run_dmenu(title_list, ['-l', '10'])

    # Focus the selected window
    if selection:
        con_id = window_dict[selection.rstrip()]
        i3.command(sys.argv[2], con_id=con_id)

def select_workspace():
    workspaces = i3.get_workspaces()
    names = [w['name'] for w in workspaces if not w['focused']]
    return run_dmenu('\n'.join(names)).rstrip()

@command
def workspace_do():
    selection = select_workspace()
    cmd = "" if len(sys.argv) == 2 else sys.argv[2]
    i3.command(cmd, 'workspace', selection)

@command
def full_rename_workspace():
    newname = run_dmenu("", ['-noinput'])
    i3.command('rename workspace to', newname)

@command
def rename_workspace():
    num = None
    workspaces = i3.get_workspaces()
    for w in workspaces:
        if w['focused']:
            num = w['name'].split(':')[0]

    # Use dmenu to prompt the user for a new name
    newname = run_dmenu("", ['-noinput'])
    if newname == "":
        return

    if num:
        newname = num + ':' + newname

    i3.command('rename workspace to', newname)

    if num:
        i3.command('bindsym',  'Mod4+'+num, 'workspace', newname)

if __name__ == "__main__":
    action = sys.argv[1]
    if action in CMDS.keys():
        CMDS[action]()
    else:
        print "Unknown command line argument"
