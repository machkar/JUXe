var spawn = require('child_process').spawn,
    netlist = spawn('iwlist',['wlp3s0','s']);
    //netlist = spawn('iwlist', ['wlp3s0', 's']);


netlist.stdout.on('data', function (data) {
    var ll = String(data);
    //var re = /ESSID\:\"(.*?)\"/g
    var myarr = ll.split(/\r?\n/);
    var cellsep = /Cell \d+\ /
    var wpa2 = /.+WPA2.+/
    var wpa = /.+WPA.+/
    var myi = -1;
    var network = [], encrypted = [], type  = [];
    var qtop = [] , qbot = [] , dbm = [];
    for (i=0; i<myarr.length; i++) {
    var ss = myarr[i].trim();
    if (ss.substring(0,5) == 'Cell ') { myi = myi+1; type[myi] = 'WEP'; }
    if (ss.substring(0,7) == 'ESSID:"') { network[myi] = ss.slice(7,-1); }
    if (ss.substring(0,15)  == 'Encryption key:') { mm = ss.substring(15); if (mm == 'on') encrypted[myi] = 1; else encrypted[myi] = 0;  }
    if (ss.substring(0,8) == 'Quality=') { ssl = ss.substring(8); var phase = 0;
        var cnt = 0;
        qtop[myi]=0,qbot[myi]=0,dbm[myi]=0;
        for (lp =0; lp<ssl.length; lp++) {
            if (ssl[lp] == ' ' || ( ssl[lp] >= 'A' && ssl[lp] <= 'Z') || (ssl[lp] >= 'a' && ssl[lp] <= 'z') || ssl[lp] == '-') continue;
            if (phase == 0) if (ssl[lp] <= '9' && ssl[lp] >= '0') cnt = cnt*10+(parseInt(ssl[lp])); else { phase = 1; qtop[myi] = cnt; cnt = 0; }
            else if (phase == 1) if (ssl[lp] <= '9' && ssl[lp] >= '0') cnt = cnt*10+(parseInt(ssl[lp])); else { phase = 2; qbot[myi] = cnt; cnt = 0; }
            else if (phase == 2) if (ssl[lp] <= '9' && ssl[lp] >= '0') cnt = cnt*10+(parseInt(ssl[lp])); else { break; }
        }
        dbm[myi]  = -cnt;
    }
    if (ss.substring(0,4) == 'IE: ') {
       var wpa2_b = ss.search(wpa2);
       if (wpa2_b != -1) type[myi] = 'WPA2';
       else {
            var wpa_b = ss.search(wpa);
            if (wpa_b != -1) type[myi] = 'WPA';
       }
    }
    //var vline = myarr[i];
    //var vname = myarr[i].slice(7,-1);
    //
    /* connect using
     * MAKE SURE NETWORKING IS OFF AND NETWORK MANAGER IS OFF
     * if (WPA) {
     * wpa_passphrase ESSID password > wpa.conf
     * wpa_supplicant -iwlan0 -c./wpa.conf -Dwext
     * dhclient wlan0 }
     * else {
     *  if (encrypted == 0)
     *  iwconfig wlan0 ESSID KHARA; dhclient wlan0
     *  else
     *  iwconfig wlan0 ESSID KHARA key PASSWORD
     * }
     * */
    }
    for (i=0; i<myi+1; i++) {
    console.log(network[i] + '/' + type[i] + '--' + encrypted[i] + '//' + qtop[i] + '/' + qbot[i] + '||' + dbm[i]);
    }
});

netlist.stderr.on('data', function (data) {
    console.log('stderr: ' + data);
});

netlist.on('close', function (code) {
    //console.log('child process exited with code ' + code);
});
