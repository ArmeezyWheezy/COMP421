package P3;

import java.sql.*;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class VaccineApp {
    private static float sqlCode = 0;      // Variable to hold SQLCODE
    private static String sqlState = "00000";  // Variable to hold SQLSTATE
    private static final String currentDate = LocalDate.now(ZoneId.of("America/Montreal")).toString(); // Get Current Date

    public static void main(String[] args) throws SQLException {
        // DB CONNECTION CODE - FROM simpleJDBC.java
        // Register the driver.  You must register the driver before you can use it.
        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        } catch (Exception cnfe) {
            System.out.println("Class not found");
        }
        String url = "jdbc:db2://winter2021-comp421.cs.mcgill.ca:50000/cs421";
        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid;
        String your_password;
        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if ((your_userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if ((your_password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection(url, your_userid, your_password);
        Statement statement = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

        boolean exitProgram = true;
        while (exitProgram) {
            Scanner input = new Scanner(System.in);
            System.out.println("VaccineApp Main Menu");
            System.out.println("\t 1. Add a Person");
            System.out.println("\t 2. Assign a slot to a Person");
            System.out.println("\t 3. Enter Vaccination information");
            System.out.println("\t 4. Exit Application");
            System.out.print("Please Enter Your Option (Number): ");
            int menuChoice = input.nextInt();
            input.nextLine();
            //Add a person
            //Assign a slot
            //Enter vaccine info
            //Close the app
            switch (menuChoice) {
                case 1: {
                    System.out.print("Please enter Health Insurance Number: ");
                    String hinsurnum = input.nextLine();
                    if (!hinsurnumExists(statement, hinsurnum)) {
                        String info = getPersonInfo(input, hinsurnum);
                        addToTable(statement, info);
                    } else {
                        System.out.println("This Person already exists in the DB! ");
                        System.out.print("Would you like to update their info? (y/n) ");
                        String choice = input.nextLine();
                        switch (choice) {
                            case "y":
                            case "Y":
                            case "Yes":
                            case "YES":
                                String values = getPersonInfo(input, hinsurnum);
                                String[] newValues = values.split(",", 10);
                                boolean returnedUpdate = updatePerson(statement, hinsurnum, newValues);
                                if (returnedUpdate) {
                                    System.out.println("DONE");
                                    break;
                                }
                            case "n":
                            case "N":
                            case "NO":
                            case "No":
                                System.out.println("Ok, person was not added/updated!");
                                break;
                        }
                    }
                    break;
                }
                case 2: {
                    System.out.print("Please enter the Full Name of the Person you'd like to assign: ");
                    String hinsurnum = getHInsurNum(statement, input.nextLine());
                    if (checkIfAssignedEnoughTimes(statement, hinsurnum)) {
                        System.out.println("Sorry this person has been assigned the required number of shots");
                    } else {
                        createVacSlot(input, statement, hinsurnum);
                        System.out.println("DONE");
                    }
                    break;
                }
                case 3: {
                    System.out.print("Please enter the name of the Vaccine: ");
                    String vaccname = input.nextLine();
                    System.out.print("Please enter the Full Name of the vaccinated individual: ");
                    String hinsurnum = getHInsurNum(statement, input.nextLine());
                    if (checkIfVaccNamesMatch(statement, hinsurnum, vaccname)) {
                        updateVacSlot(input, statement, hinsurnum, vaccname);
                        System.out.println("DONE");
                    } else
                        System.out.println("The inputted Vaccine name does not match the previously administered vaccine for this Person.");
                    break;
                }
                case 4: {
                    statement.close();
                    con.close();
                    System.out.println("Thank you, goodbye!");
                    exitProgram = false;
                    break;
                }
                default:
                    System.out.println("Sorry, your input was not valid");
            }
        }


    }

    static boolean hinsurnumExists(Statement statement, String hinsurnum) {
        try {
            String sqlQuery = "SELECT COUNT(DISTINCT NAME) AS EXISTS FROM PERSON WHERE HINSURNUM = '" + hinsurnum + "'";
            ResultSet rs = statement.executeQuery(sqlQuery);
            rs.next();
            int result = rs.getInt(1);
            return result == 1;
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
            return false;
        }
    }

    static String getPersonInfo(Scanner input, String hinsurnum) {
        System.out.print("Please enter Name: ");
        String name = "'" + input.nextLine() + "'";
        System.out.print("Please enter Gender: ");
        String gender = "'" + input.nextLine() + "'";
        System.out.print("Please enter Date of Birth (YYYY-MM-DD): ");
        String dob = "DATE('" + input.nextLine() + "')";
        System.out.print("Please enter Phone (without brackets, just numbers): ");
        String phone = input.nextLine();
        System.out.print("Please enter City: ");
        String city = "'" + input.nextLine() + "'";
        System.out.print("Please enter Postal Code: ");
        String postalcd = "'" + input.nextLine() + "'";
        System.out.print("Please enter Street Address: ");
        String streetaddr = "'" + input.nextLine() + "'";
        return "'" + hinsurnum + "', " + name + ", " + gender + ", " + dob + ", " + phone + ", " + city + ", " + postalcd + ", " + streetaddr + ", '" + currentDate + "', null";
    }

    static String getHInsurNum(Statement statement, String name) {
        try {
            String sqlQuery = "SELECT HINSURNUM FROM PERSON WHERE NAME = '" + name + "'";
            ResultSet rs = statement.executeQuery(sqlQuery);
            rs.next();
            return rs.getString(1);
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            return null;
        }
    }

    static int getNurseLicenseNum(Statement statement, String name) {
        try {
            String sqlQuery = "SELECT LICENSENUM FROM NURSE WHERE NAME = '" + name + "'";
            ResultSet rs = statement.executeQuery(sqlQuery);
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
            return 0;
        }
    }

    static int getVialBatchNum(Statement statement, String vname, String vialId) {
        try {
            String sqlQuery = "SELECT BATCHNO FROM VIAL WHERE VNAME = '" + vname + "' AND VIALID = '" + vialId + "'";
            ResultSet rs = statement.executeQuery(sqlQuery);
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
            return 0;
        }
    }

    static void addToTable(Statement statement, String valuesInput) {
        try {
            String insertSQL = "INSERT INTO PERSON VALUES (" + valuesInput + ") ";
            statement.executeUpdate(insertSQL);
            System.out.println("DONE");
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
        }
    }

    static boolean updatePerson(Statement statement, String hinsurnum, String[] valuesInput) {
        try {
            String updateSQL = "UPDATE PERSON SET NAME = " + valuesInput[1] +
                    ", GENDER = " + valuesInput[2] +
                    ", DOB = " + valuesInput[3] +
                    ", PHONE = " + valuesInput[4] +
                    ", CITY = " + valuesInput[5] +
                    ", POSTALCD = " + valuesInput[6] +
                    ", STREETADDR = " + valuesInput[7] +
                    " WHERE HINSURNUM = '" + hinsurnum + "'";
            statement.executeUpdate(updateSQL);
            return true;
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
            return false;
        }
    }

    static boolean checkIfAssignedEnoughTimes(Statement statement, String hinsurnum) {
        try {
            String querySQL = "SELECT Name " +
                    "FROM (SELECT PERSON.HINSURNUM as Name, VNAME as Vaccname, COUNT(*) as numSlots from PERSON, VACCSLOT WHERE PERSON.HINSURNUM = VACCSLOT.HINSURNUM GROUP BY PERSON.HINSURNUM, VNAME), VACCINE " +
                    "WHERE (Vaccname = VACCINE.VNAME AND numSlots = DOSE) OR (Vaccname is null AND numSlots > 1)";
            ResultSet rs = statement.executeQuery(querySQL);
            List<String> names = new ArrayList<>();
            while (rs.next()) {
                names.add(rs.getString(1));
            }

            return names.contains(hinsurnum);
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
            return false;
        }
    }

    static void createVacSlot(Scanner input, Statement statement, String hinsurnum) {
        try {
            String querySQL = "SELECT VSLOT, LOCNAME, VDATE, VTIME FROM VACCSLOT WHERE VACCSLOT.HINSURNUM is null AND VDATE > DATE('" + currentDate + "') ORDER BY VDATE";
            ResultSet rs = statement.executeQuery(querySQL);
            int rowcount = 0;
            if (rs.last()) {
                rowcount = rs.getRow();
                rs.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
            }
            if (rowcount > 0) {
                System.out.println("Here are the available time slots!");
                System.out.println("Please choose one of the following slots (enter slot location, index and date): ");
                System.out.println("Slot Index |\t Loc Name|\t Date |\t Time |\t");
                while (rs.next()) {
                    String slotInd = rs.getString(1);
                    String locname = rs.getString(2);
                    String vdate = rs.getString(3);
                    String vtime = rs.getString(4);
                    System.out.println(slotInd + "\t" + locname + "\t" + vdate + "\t" + vtime);
                }
                System.out.print("Your choice (Location): ");
                String vaccLoc = input.nextLine();
                System.out.print("Your choice (slot index): ");
                int vslot = input.nextInt();
                input.nextLine();
                System.out.print("Your choice (Date): ");
                String date = input.nextLine();

                // LIMITATION: Not checking if hinsurnum is existing in DB
                String updateQuerySQL = "UPDATE VACCSLOT SET HINSURNUM = '" + hinsurnum + "', ASGNDATE = '" + currentDate + "' WHERE LOCNAME = '" + vaccLoc + "' AND VSLOT = '" + vslot + "' AND VDATE = '" + date + "'";
                statement.executeUpdate(updateQuerySQL);
            } else {
                System.out.println("Sorry, no slots are available for this location anymore.");
            }

        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
        }

    }

    static boolean checkIfVaccNamesMatch(Statement statement, String hinsurnum, String vaccname) {
        try {
            String querySQL2 = "SELECT DISTINCT VNAME FROM VACCSLOT WHERE HINSURNUM = '" + hinsurnum + "'";
            ResultSet rs2 = statement.executeQuery(querySQL2);
            List<String> vacname = new ArrayList<>();
            while (rs2.next()) {
                if (rs2.getString(1) != null) {
                    vacname.add(rs2.getString(1));
                }
            }
            return vacname.isEmpty() || vacname.contains(vaccname);
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
            return false;
        }
    }

    static boolean displayAssignedSlots(Statement statement, String hinsurname) {
        try {
            String querySQL = "SELECT VSLOT, LOCNAME, VDATE, VTIME FROM VACCSLOT WHERE VACCSLOT.HINSURNUM = '" + hinsurname + "' AND VNAME is null ORDER BY VDATE";
            ResultSet rs = statement.executeQuery(querySQL);
            int rowcount = 0;
            if (rs.last()) {
                rowcount = rs.getRow();
                rs.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
            }
            if (rowcount > 0) {
                System.out.println("Slot Index |\t Loc Name|\t Date |\t Time |\t");
                while (rs.next()) {
                    String slotInd = rs.getString(1);
                    String locname = rs.getString(2);
                    String vdate = rs.getString(3);
                    String vtime = rs.getString(4);
                    System.out.println(slotInd + "\t" + locname + "\t" + vdate + "\t" + vtime);
                }
                return true;
            } else {
                System.out.println("Sorry, no slots are available for this person to update anymore.");
                return false;
            }

        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
            return false;
        }
    }

    static void updateVacSlot(Scanner input, Statement statement, String hinsurnum, String vaccname) {
        try {
            System.out.println("Please select which of the attributed vaccine slots you are entering info for: ");
            if (displayAssignedSlots(statement, hinsurnum)) {
                System.out.println("Your choice (Date): ");
                String date = input.nextLine();
                System.out.println("Your choice (Vaccine Slot Index): ");
                int vslot = input.nextInt();
                input.nextLine();
                System.out.println("Please enter the name of the Nurse who vaccinated the Person: ");
                String nurseName = input.nextLine();
                int licenseNum = getNurseLicenseNum(statement, nurseName);
                System.out.println("Please enter the Vial Id of the vaccine: ");
                String vialID = input.nextLine();
                int batchNo = getVialBatchNum(statement, vaccname, vialID);
                String sqlUpdate = "UPDATE VACCSLOT SET LICENSENUM = " + licenseNum + ", VNAME = '" + vaccname + "', VIALID = '" + vialID + "', BATCHNO = " + batchNo + " WHERE HINSURNUM = '" + hinsurnum + "' AND VDATE = '" + date + "' AND VSLOT = " + vslot;
                statement.executeUpdate(sqlUpdate);
            }
        } catch (SQLException e) {
            sqlCode = e.getErrorCode(); // Get SQLCODE
            sqlState = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
            System.out.println(e.getMessage());
        }
    }
}

