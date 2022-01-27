<html>
   <head>

        <script type = "text/javascript" src = "jquery/jquery-3.4.1.min.js"/>
        <script type = "text/javascript">
        </script>

        <script type = "text/javascript">

        function onOrgSelected() {

            // If a valid one is selected
            var val = document.getElementById("org-select").value;
            if(val > 0) {
                // Get and display the required data
                var formValues = $("form").serialize();
                $("#total-rescued").load("totalRescuedAmountResult.php?" + formValues);
            } else {
                // Otherwise, clear the data
                $("#total-rescued").empty();
            }
            
        
        }
        function onBodyLoad() {
            // Make the dropdown selection blank at start
            document.getElementById("org-select").selectedIndex = 0;
        }

        </script>

    </head>
        <h3>Total Amount Animals Were rescued for a Given Organization In a Year of Your Choice </h3>
		<h4>Please choose an organization </h4>
        <?php

            // DB connection
            require "DBConn.php";

            // Query
            $rows=$DB->query("SELECT O.orgID, O.orgName FROM Organization O");

			//DropDown
			$select = '<select id="org-select" name="org" name="select">';
            $select.='<option value=""></option>';
            foreach($rows as $row) {
                $select.='<option value="'.$row['orgID'].'">'.$row['orgName'].'</option>';
            }
            $select.='</select>';

            // Construct dropdown element
            echo '<form id="org-form">';
            echo $select;
            echo '</form>';
        ?>
		<h4> Please enter a year and click submit </h4>
		<form id="yearbox" method="get">
			<label for="year">Year:</label><br><br>
			<input type="text" id="year" name="year" value="2020"><br><br>
			<input type="button" value="Submit" onClick="onOrgSelected()">
		</form>

        <!-- The container to put the DB results into -->
        <div id="total-rescued"></div>

    </body>
</html>