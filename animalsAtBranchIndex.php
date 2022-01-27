<html>
   <head>

        <script type = "text/javascript" src = "jquery/jquery-3.4.1.min.js"/>
        
        <!-- If these two lines are removed, the scripts below don't work :( -->
        <script type = "text/javascript">
        </script>

        <script type = "text/javascript">
        
        // Called when the SPCA Branch dropdown selection changes
        function onSPCSBranchSelected() {

            // If a valid one is selected
            var val = document.getElementById("branch-select").value;
            if(val > 0) {
                // Get and display the required data
                var formValues = $("form").serialize();
                $("#animals-at-branch").load("animalsAtBranchResult.php?" + formValues);
            } else {
                // Otherwise, clear the data
                $("#animals-at-branch").empty();
            }
            
        }

        // Called when document body loads
        function onBodyLoad() {
            // Make the dropdown selection blank at start
            document.getElementById("branch-select").selectedIndex = 0;
        }

        </script>

    </head>

    <body onload="onBodyLoad()">

        <h3>Animals at SPCA branch</h3>

        <?php

            // DB connection
            require "DBConn.php";

            // Query
            $rows=$DB->query("SELECT O.orgID, O.orgName FROM Organization O, SPCA_Branch S WHERE O.orgID=S.orgID");

            // Display dropdown selector
            $select = '<select id="branch-select" name="branch" onchange="onSPCSBranchSelected()" name="select">';
            $select.='<option value=""></option>';
            foreach($rows as $row) {
                $select.='<option value="'.$row['orgID'].'">'.$row['orgName'].'</option>';
            }
            $select.='</select>';

            // Construct form with dropdown element to submit selected data
            echo '<form id="branch-form">';
            echo $select;
            echo '</form>';

        ?>

        <!-- The container to put the DB results into -->
        <div id="animals-at-branch"></div>

    </body>
</html>