<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.js" type="text/javascript"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.min.js" type="text/javascript"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.js" type="text/javascript"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.min.js" type="text/javascript"></script> 
</head>
<body>
<canvas id="scatter" style="margin-left: 13%; position: absolute; width: 1000px; height: 350px"></canvas>

<script>

var ctx = document.getElementById('scatter');

var chart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: makeLabels().labels,
    datasets: [{
      type: 'line',
      label: 'Data',
      data: makeLabels().labels,
      fill: false,
      backgroundColor: "rgba(218,83,79, .7)",
      borderColor: "rgba(218,83,79, .7)",
      pointRadius: 0
    }, {
      type: 'bubble',
      label: 'Data2',
      data: makeBubbles(),
      backgroundColor: "rgba(76,78,80, .7)",
      borderColor: "transparent"
    }]
  },
  options: {
    scales: {
      xAxes: [{
        type: 'linear',
        position: 'bottom',
        ticks: {
          autoSkip: true,
          max: Math.max(...makeLabels().array)
        }
      }]
    }
  }
});

function makeLabels() {
  var arr = [
    5.786341562524039,
    8.79665220908912,
    8.383664554147352,
    6.512236758312074,
    5.977927375174986,
    5.795411971799503,
    7.483008448660743,
    10.944857778345781,
    9.731148601839132,
    9.299830925080316,
    5.829437054802131,
    5.89389536362796,
    8.003445135489207,
    6.0428956435913745,
    6.0170861155256885,
    8.8858198627947,
    8.063495958147668,
    8.241177297897147,
    9.515870969001629,
    10.22551286060783,
    10.292722396729182,
    8.251753293888944,
    7.146226463060593,
    5.988918648803384,
    6.496517457556567,
    7.432891288115246,
    9.344935207444069,
    5.843592666018152,
    6.12315092706915,
    8.687749798119956,
    8.291409485783507,
    7.863325849087245,
    10.53809438360669,
    6.702738926037372,
    6.784877019135593,
    8.490500493936208,
    9.658488190644242,
    9.343801630924382,
    11.52492623170561,
    10.00207659039105,
    8.57312564934666,
    6.846018047888539,
    9.162893182611098,
    5.9869519001247955,
    5.576952345873481,
    8.595164584671123,
    7.431108145074283,
    9.85430793938902
  ];

  arr = arr.sort((a, b) => a - b);
  var newarr = arr.map(item => ({ x: item, y: item }));
  return {
    labels: newarr,
    array: arr
  };
};

function makeBubbles() {
  var arr = [
    6.045005314036012,
    8.934850340289763,
    8.501876487304344,
    6.63200177739563,
    6.815639990074331,
    9.455871442168021,
    10.745464137157782,
    6.293419278846481,
    10.559036702680755,
    6.371611847231857,
    9.472242991440476,
    9.356084386028888,
    6.761572768804055,
    9.556409270127691,
    9.331052447138447,
    10.291569105033412,
    6.018593214496234,
    6.354370040797351,
    10.302599186672117,
    6.326149473155099,
    10.274947655341608,
    8.635331719433278,
    10.425757440186377,
    8.760923376338836,
    6.345636360828596,
    9.974784434418162,
    10.486149999920801,
    6.054439346269371,
    10.963185747705012,
    6.049733455231958,
    10.429960121878297,
    5.857933154483459,
    6.368187186350492,
    9.474625866621567,
    10.878160393673937,
    10.696480068065789,
    9.838949031398556,
    7.050989447068045,
    11.932378944680496,
    6.489204931325317,
    5.564520407322694,
    5.849324779946859,
    6.144185634125646,
    9.550662331752143,
    5.8971538676367405,
    5.855071922202427,
    7.586803535162581,
    10.55664572487971
  ];
  
  arr = arr.map(function(item, i) {
    return {x: item, y:arr[i - 1]}
  });
  
  return arr;
};
</script>


</body>
</html>