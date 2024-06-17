
<style>
    body {font-family: Arial, Helvetica, sans-serif;}
    
    /* The Modal (background) */
    .modal {
      display: none;
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      padding-top: 100px; /* Location of the box */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }
    
    /* Modal Content */
    .modal-content {
      position: relative;
      background-color: #fefefe;
      margin: auto;
      padding: 0;
      border: 1px solid #888;
      width: 80%;
      box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
      -webkit-animation-name: animatetop;
      -webkit-animation-duration: 0.4s;
      animation-name: animatetop;
      animation-duration: 0.4s
    }
    
    /* Add Animation */
    @-webkit-keyframes animatetop {
      from {top:-300px; opacity:0} 
      to {top:0; opacity:1}
    }
    
    @keyframes animatetop {
      from {top:-300px; opacity:0}
      to {top:0; opacity:1}
    }
    
    /* The Close Button */
    .close {
      color: white;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }
    
    .close:hover,
    .close:focus {
      color: #000;
      text-decoration: none;
      cursor: pointer;
    }
    
    .modal-header {
      padding: 2px 16px;
      background-color: #00028a;
      color: white;
    }
    
    .modal-body {padding: 2px 16px;}
    
    </style>
    <script src="https://d3js.org/d3.v4.min.js"></script>
    
    <!-- The Modal -->
    <div id="avvisiModal" class="modal">
    
      <!-- Modal content -->
      <div class="modal-content">
        <div class="modal-header">
        <h2>Avvisi</h2>
          <span class="close">&times;</span>
        </div>
        <div class="modal-body">
          
        </div>
      </div>
    
    </div>
    
    <script>
    var modal = document.getElementById("avvisiModal");
    var span = document.getElementsByClassName("close")[0];
    
    span.onclick = function() {
      modal.style.display = "none";
    }
    
    window.onclick = function(event) {
      if (event.target == modal) {
        modal.style.display = "none";
      }
    }

    d3.json("/avvisi/db.php?sistema=<?php echo $_REQUEST['sistema']?>", function(d){
        console.log(d);
        d.forEach(function(av){
            modal.style.display = "block";
            d3.select(".modal-body").append("p").html(av);
        })
    })
    </script>
    