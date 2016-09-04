/*
MIDI data handler for particle engine
Author: Donya Quick
*/

class MidiHandler {
  // MIDI setup information
  boolean quietMode = false;
  int outDevNum = 1; // this will not always be the same on all machines. Always check device numbers when running on another system!
  MidiDevice outDev; 
  int chan = 0; // current channel, to be rotated as we go to minimize distortion/artifacts of duplicate pitches on the same channel
  int maxVol = 100; // needs to be low to avoid overloading the synthesizer (better to use 20 for other synths with a long decay)
  int minVol = 20; 
  
  MidiHandler() {
    if (quietMode) {
      maxVol = 20;
      minVol = 2;
    }
  }
  
    // to be called before any sound production happens
  public void setupMidi(){ 
    try{
      List<MidiDevice> outDevs = MidiUtils.getOutputDevices();
      outDev = outDevs.get(outDevNum);
      print(outDev.getDeviceInfo().getName());
      outDev.open();
    } catch (Exception e) {
      println(e.getMessage()); 
    }
  }
  
  // to be called whenever a sound needs to happen at a particular pitch number (pnum)
  public void sendPitch(int pnum, float volScale, float duration) {
    println(volScale);
    int vol = round((maxVol-minVol) * volScale + minVol);
    try {
      MidiUtils.playNote(outDev, chan, pnum, vol, duration);
      chan = chan+1; // minimize the chance of overlapping pitches on the same channel
      if(chan >=9) {
         chan = 0; 
      }
    } catch (Exception e) {  
      println(e.getMessage());
    }
  }
  
  public void sendPitch(int pnum, float volScale) {
    sendPitch(pnum, volScale, 0.5); 
  }
}