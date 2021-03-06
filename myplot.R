<!doctype HTML>
<meta charset = 'utf-8'>
<html>
  <head>
    <link rel='stylesheet' href='/Library/Frameworks/R.framework/Versions/3.4/Resources/library/rCharts/libraries/nvd3/css/nv.d3.css'>
    <link rel='stylesheet' href='/Library/Frameworks/R.framework/Versions/3.4/Resources/library/rCharts/libraries/nvd3/css/rNVD3.css'>
    
    <script src='/Library/Frameworks/R.framework/Versions/3.4/Resources/library/rCharts/libraries/nvd3/js/jquery-1.8.2.min.js' type='text/javascript'></script>
    <script src='/Library/Frameworks/R.framework/Versions/3.4/Resources/library/rCharts/libraries/nvd3/js/d3.v3.min.js' type='text/javascript'></script>
    <script src='/Library/Frameworks/R.framework/Versions/3.4/Resources/library/rCharts/libraries/nvd3/js/nv.d3.min-new.js' type='text/javascript'></script>
    <script src='/Library/Frameworks/R.framework/Versions/3.4/Resources/library/rCharts/libraries/nvd3/js/fisheye.js' type='text/javascript'></script>
    
    <style>
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 800px;
      height: 400px;
    }  
    </style>
    
  </head>
  <body >
    
    <div id = 'chart147553da93ac7' class = 'rChart nvd3'></div>    
    <script type='text/javascript'>
 $(document).ready(function(){
      drawchart147553da93ac7()
    });
    function drawchart147553da93ac7(){  
      var opts = {
 "dom": "chart147553da93ac7",
"width":      800,
"height":      400,
"x": "namesOfFollowers",
"y": "numberOfFollowers",
"type": "multiBarChart",
"id": "chart147553da93ac7" 
},
        data = [
 {
 "numberOfFollowers": 12,
"namesOfFollowers": "kennyc11" 
},
{
 "numberOfFollowers": 7,
"namesOfFollowers": "juliaellen" 
},
{
 "numberOfFollowers": 8,
"namesOfFollowers": "emmalouiser" 
},
{
 "numberOfFollowers": 10,
"namesOfFollowers": "toconno5" 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .width(opts.width)
          .height(opts.height)
          
        if (opts.type != "bulletChart"){
          chart
            .x(function(d) { return d[opts.x] })
            .y(function(d) { return d[opts.y] })
        }
          
         
        
          
        

        
        
        
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>
    
    <script></script>    
  </body>
</html>
