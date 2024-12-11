import React, { useState, useRef, useEffect } from "react";
import Navbar from "../Navbar";
import axios from "axios";
import { Chart } from "react-google-charts";

function Hodanalytics() {
  const userRef = useRef(null);
  const [rollNumber, setRollNumber] = useState('');
  const [basicacademic, setbasicacademic] = useState(null);
  const [marks, setMarks] = useState(null);
  const [sem, setSem] = useState(null);
  const [gpa, setGpa] = useState(null);
  const [stafflist, setStafflist] = useState(null);
  const [staffclicked, setstaffclicked] = useState(false);
  const [subjectclicked, setSubjectclicked] = useState(false);
  const [staffsubjects, setstaffsubjects] = useState(null);
  const [studentlist, setstudentlist] = useState(null);
  const [selectedsubjectid, setselectedsubjectid] = useState(null);
  const [selectedteacherid, setselectedteacherid] = useState(null);

  const handleInputChange1 = (event) => {
    setRollNumber(event.target.value);
  };

  const handlestaffclick = (teacherId) => {
    setstaffclicked(true);
    setselectedteacherid(teacherId);
    axios.get(`http://localhost:5000/getstaffsubjects/${teacherId}`)
      .then((response) => {
        setstaffsubjects(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const subjectclick = (subjectId) => {
    setselectedsubjectid(subjectId);
    axios.get(`http://localhost:5000/getstudentlist/${selectedteacherid}/${subjectId}`)
      .then((response) => {
        setstudentlist(response.data);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  useEffect(() => {
    axios.get(`http://localhost:5000/getstafflist`)
      .then((response) => {
        setStafflist(response.data);
      })
      .catch((error) => {
        console.log(error);
      });

    axios.get(`http://localhost:5000/getgpa/${rollNumber}`)
      .then(response => {
        if (response.data) {
          setGpa(response.data);
        } else {
          setGpa(null);
          alert('No GPA found');
        }
      })
      .catch(err => {
        console.log(err);
      });
  }, [sem]);

  const handleInputChange = (event) => {
    const selectedSemester = event.target.value;
    setSem(selectedSemester);

    axios.get(`http://localhost:5000/basicacademic/${rollNumber}`)
      .then(response => {
        if (response.data) {
          setbasicacademic(response.data);
        } else {
          setbasicacademic(null);
          alert('No academic found');
        }
      })
      .catch(error => {
        console.log(error);
      });

    axios.get(`http://localhost:5000/getsemestermarks/${rollNumber}/${selectedSemester}`)
      .then(response => {
        if (response.data) {
          setMarks(response.data);
        } else {
          setMarks(null);
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

      <div className='mark-search-head'>
            <center>
                <h1>Enter Roll Number Of Student</h1>
            </center>
            <input
                className='rollnumber-input'
                type="number"
        placeholder="Enter Roll Number"
        value={rollNumber}
        onChange={handleInputChange1}
            />
            <button className='add-btn'>Search</button>
        </div>

        <div id='analytics-student'>
        
        <div className="gpa-analytics">
            <center><h1>GPA Trend</h1></center>
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

      {/* {stafflist && !staffclicked && <h2>Staff Details</h2>}
      {stafflist && !staffclicked && stafflist.map((staff, index) => (
        <div onClick={() => { handlestaffclick(staff.teacherId) }} className='view-form' key={index}>
          <h2>{index + 1}</h2>
          <p className='view-field'><strong>Staff ID:</strong> {staff.teacherId}</p>
          <p className='view-field'><strong>Staff Name:</strong> {staff.teacher_name}</p>
        </div>
      ))}

      {staffclicked && <button className="delete-btn" onClick={() => { setstaffclicked(false) }}>Back</button>}
      {staffclicked && staffsubjects && staffsubjects.map((subject, index) => (
        <div onClick={() => subjectclick(subject.SubjectID)} className='view-form' key={index}>
          <h2>{index + 1}</h2>
          <p className='view-field'><strong>Subject ID:</strong> {subject.SubjectId}</p>
          <p className='view-field'><strong>Subject Name:</strong> {subject.SubjectName}</p>
        </div>
      ))}
      {subjectclicked && <button className="delete-btn" onClick={() => { setSubjectclicked(false) }}>Back</button>}
      {subjectclicked && <div></div>} */}
    </>
  );
}

export default Hodanalytics;
