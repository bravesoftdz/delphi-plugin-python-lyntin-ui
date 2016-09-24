import re, sys, os, select, types, Queue, sys, time
from lyntin import ansi, engine, event, utils, exported, config
from lyntin.ui import base, message

import demodll
buffer = Queue.Queue()
myui = None

def recv():
  if buffer.empty():
    time.sleep(0.01)
    return None
  else:
    s = buffer.get_nowait()
    return s
  
def send(s):
  #get_ui_instance().handleinput(s)
  myui.handleinput(s)
  
def get_ui_instance():
  global myui
  if myui == None:
    myui = Kaiui()
  return myui

class Kaiui(base.BaseUI):

  def __init__(self):
    print "kaiui : init"
    base.BaseUI.__init__(self)
    exported.hook_register("to_user_hook", self.write)        
    
  def wantMainThread(self):
    print "kaiui : wantMainThread"
    return 1

  def runui(self):    
    print "kaiui : runui"    
    demodll.run()
     
  def shutdown(self, args):
    base.BaseUI.__init__(self)
    print "kaiui : shutdown"    
    demodll.kill()
    
  def munge(self,s):
    crlf = '\n\r'
    lines = s.splitlines()
    trailing = False
    if s.endswith('\r') or s.endswith('\n'):
      trailing = True
    result = crlf.join(lines)
    if trailing:
      result = result + crlf
    return result  
      
  def write(self, args):
    msg = args["message"]

    if type(msg) == types.StringType:
      msg = message.Message(msg, message.LTDATA)
      msg.data = msg.data
    elif msg.type==message.USERDATA:      
      msg.data = msg.data      
      
    #elif msg.type==message.ERROR:
    #  msg.data = msg.data
    #elif msg.type==message.LTDATA:
    #  msg.data = msg.data
    #elif msg.type==message.MUDDATA:
    #  msg.data = msg.data

    text = self.munge(msg.data)    
    #ses = msg.session

    #if line == '' or self.showTextForSession(ses) == 0:
    #  return

    global buffer
    buffer.put(text)
    #print buffer.get()
    return

  def showTextForSession(self, ses):
    return 1

  def prompt(self):
    # nicety for showing the user that lyntin wants input from him
    pass