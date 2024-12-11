import React, { useState, useRef, useEffect } from "react";
import Navbar from "../../Navbar";
import axios from "axios";
import { Chart } from "react-google-charts";

function Visualization() {
  const userRef = useRef(null);
  const [basicacademic, setbasicacademic] = useState(null);
  const [marks, setMarks] = useState(null);
  const [sem, setSem] = useState(null);
  const [gpa, setGpa] = useState(null);
  const [cgpa, setCgpa] = useState(null);

  useEffect(() => {
    userRef.current = localStorage.getItem('rollnumber');
    axios.get(`http://localhost:5000/getgpa/${userRef.current}`)
      .then(response => {
        if (response.data) {
          setGpa(response.data);
          console.log("gpa", response.data);
        } else {
          setGpa(null);
          alert('No GPA found');
        }
      })
      .catch(err => {
        console.log(err);
      });
  }, [sem]);

  useEffect(() => {
    userRef.current = localStorage.getItem('rollnumber');
    axios.get(`http://localhost:5000/getcgpa/${userRef.current}`)
      .then(response => {
        if (response.data) {
          setCgpa(response.data.cgpa);
          console.log("cgpa is", response.data);
        } else {
          alert('No CGPA found');
        }
      })
      .catch(err => {
        console.log(err);
      });
  }, []);

  const handleInputChange = (event) => {
    const selectedSemester = event.target.value;
    setSem(selectedSemester);

    axios.get(`http://localhost:5000/basicacademic/${userRef.current}`)
      .then(response => {
        if (response.data) {
          setbasicacademic(response.data);
        } else {
          alert('No academic found');
        }
      })
      .catch(error => {
        console.log(error);
      });

    axios.get(`http://localhost:5000/getsemestermarks/${userRef.current}/${selectedSemester}`)
      .then(response => {
        if (response.data) {
          console.log("marks=", response.data);
          setMarks(response.data);
        } else {
          alert('No marks found');
        }
      })
      .catch(err => {
        console.log(err);
      });
  };

  const renderChart = (marksData) => {
    const chartData = [['SubjectID', 'Marks', 'Avg. Mark', 'Max. Mark']];
    marksData.forEach((mark) => {
      chartData.push([mark.SubjectID.toString(), mark.MarksObtained, mark.AverageMark, mark.MaximumMark]);
    });
  
    return (
      <center>
      <Chart
        className="graph-view"
        chartType="ColumnChart"
        loader={<div>Loading Chart</div>}
        data={chartData}
        options={{
          chartArea: { width: '75%' },
          title: 'Marks, Average Mark, and Maximum Mark',
          hAxis: { 
            title: 'SubjectID',
            minValue: 0,
          },
          vAxis: { title: 'Marks', minValue: 0, maxValue: 100, ticks:[0,10,20,30,40,50,60,70,80,90,100]},
        }}
      />
      </center>
    );
};

  

  const renderGpaChart = (gpaData) => {
    const chartData = [['Semester', 'GPA']];
    gpaData.forEach((gpa) => {
      chartData.push([gpa.semester.toString(), gpa.gpa]);
    });

    return (
      <Chart
      className="graph-view"
        chartType="LineChart"
        loader={<div><center>Loading Chart</center></div>}
        data={chartData}
        options={{
          title: 'GPA',
          chartArea: { width: '80%' },
          hAxis: { title: 'Semester' },
          vAxis: { title: 'GPA', minValue: 6, maxValue: 10, ticks: [6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10] },
        }}
      />
    );
  };

  return (
    <>
      <Navbar />

      <div id='analytics-student'>
        
        <div className="gpa-analytics">
            <center><h1>Your GPA Trend</h1></center>
          <div>
            {gpa && renderGpaChart(gpa)}
          </div>
        </div>

        <div className="mark-analytics">
          <center><h1>Semester-wise Marks</h1></center>
          <div className="sem-selector">
            <b><label htmlFor="semSelect">Select Semester : </label></b>
            <select
              id="semSelect"
              value={sem || ''}
              onChange={handleInputChange}
            >
              <option value="">Select Semester</option>
              {[...Array(8).keys()].map((num) => (
                <option key={num + 1} value={num + 1}>{num + 1}</option>
              ))}
            </select>
          </div>

          <div className="mark-graph">
            {marks && renderChart(marks)}
          </div>
        </div>



      </div>
      
    </>
  );
}

export default Visualization;
