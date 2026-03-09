### This example uses the Markovify Library available here:
### https://pypi.org/project/markovify/#basic-usage
## Instalaltion: pip install markovify
## By Citlali Hernández, 2026

import random
import markovify
from pythonosc import dispatcher, osc_server

# ────── CONFIGURATION

PORT = 12000
IP   = "127.0.0.1"

TEXT_PATH  = "---the path of your file---" #/Documents/....
STATE_SIZE = 1
MAX_CHARS  = 280

# ─── MARKOVIFY MODEL 

def build_model(path, state_size=1):
    with open(path) as f:
        text = f.read()
    return markovify.Text(text, state_size=state_size)

def get_sentence(model):
    sentence = model.make_short_sentence(MAX_CHARS)
    return sentence if sentence else "[I could not generate a new phrase.]"

# ─────── HANDLERS OSC 

previous_cd = -1

def handle_wekinator(address, *args):
    global previous_cd, text_model
    cd = int(args[0])

    if cd == previous_cd:
        return

    previous_cd = cd
    print(f"\n[OSC] {address} → clase {cd}")

    if cd == 1:
        print("  Class 1: Sleeping ...")

    elif cd == 2:
        print("  Class 2:", get_sentence(text_model))

    elif cd == 3:
        new_state = random.randint(1,4)  # markovify won't accept state_size=0
        print(f"  Class 3: Changing state_size randomly to → {new_state}")
        text_model = build_model(TEXT_PATH, new_state)

def handle_generic(address, *args):
    print(f"[OSC] {address} -> {args}")

# ──── MAIN──────


if __name__ == "__main__":
    print("Building Markovify Model...")
    text_model = build_model(TEXT_PATH, STATE_SIZE)
    print(f"Model ready.state_size = {STATE_SIZE}\n")

    disp = dispatcher.Dispatcher()
    disp.map("/wek/outputs", handle_wekinator)
    disp.set_default_handler(handle_generic)

    server = osc_server.ThreadingOSCUDPServer((IP, PORT), disp)
    print(f"Listening to OSC Messages in {IP}:{PORT} ...")

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer Stopped.")
