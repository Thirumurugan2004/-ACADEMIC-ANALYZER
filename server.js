const express = require("express");
const cors = require("cors");
const mysql = require('mysql');
const jwt = require('jsonwebtoken');
const body_parser = require("body-parser");
const multer=require('multer');
const path=require('path');
const fs = require('fs');
const nodemailer = require('nodemailer');
const crypto = require('crypto');
require('dotenv').config()
const app = express();

app.use(express.static('prof-image'));
app.use(express.json());
app.use(cors());
app.use(body_parser.urlencoded({ extended: true }));

const dbConfig = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'istdept'
};


const db = mysql.createConnection({
    host: dbConfig.host,
    user: dbConfig.user,
    password: dbConfig.password,
    database: dbConfig.database
});

app.listen(5000, () => console.log("Server listening on port: 5000"));

db.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL database');
});

app.post('/tokencheck', async (req, res) => {
    const { token } = req.body;
    jwt.verify(token, 'secret', (err, decoded) => {
        if (err) {
            console.error('Failed to verify token: ', err.message);
            res.status(401).json({ success: false, decoded });
        }
        else {
            console.log('Decoded token: ', decoded);
            res.status(201).json({ success: true, decoded });
        }
    })
})

app.post('/registerstudent', async (req, res) => {

  const { rollnumber, username, password, email, year_of_joining, department, course } = req.body;

  // Hash the password
  const hashedPass = crypto.createHash('sha256').update(password).digest('hex');

  // Query to insert into students table
  const studentQuery = `INSERT INTO students (rollnumber, username, password, email, year_of_joining) VALUES(?,?,?,?,?);`;

  // Query to insert into student_academic_details table
  const academicDetailsQuery = `INSERT INTO student_academic_details (RollNumber) VALUES(?);`;

  const studentDetailsQuery = `INSERT INTO studentdetails(RollNumber) VALUES(?);`;

  const marksQuery = `INSERT INTO marks(RollNumber,SubjectID,Semester,MarksObtained,Grade) SELECT ? as Rollnumber, SubjectID, Semester, 0 as MarksObtained, NULL as Grade from subjects;
  `
  // Execute both queries in a transaction
  db.beginTransaction((err) => {
      if (err) {
          console.error(err);
          res.status(500).json({ success: 0 });
          return;
      }

      db.query(studentQuery, [rollnumber, username, hashedPass, email, year_of_joining], (error, result) => {
          if (error) {
              console.error(error);
              return db.rollback(() => {
                  res.status(500).json({ success: 0 });
              });
          }

          db.query(academicDetailsQuery, [rollnumber], (academicError, academicResult) => {
              if (academicError) {
                  console.error(academicError);
                  return db.rollback(() => {
                      res.status(500).json({ success: 0 });
                  });
              }

              db.query(studentDetailsQuery, [rollnumber], (studentDetailsError, studentDetailsResult) => {
                if (studentDetailsError) {
                    console.error(studentDetailsError);
                    return db.rollback(() => {
                        res.status(500).json({ success: 0 });
                    });
                }

                db.query(marksQuery, [rollnumber], (marksError, marksResult) => {
                  if (studentDetailsError) {
                      console.error(studentDetailsError);
                      return db.rollback(() => {
                          res.status(500).json({ success: 0 });
                      });
                  }

                // Commit the transaction if both queries are successful
                db.commit((commitError) => {
                    if (commitError) {
                        console.error(commitError);
                        return db.rollback(() => {
                            res.status(500).json({ success: 0 })
                        })
                    }
                    res.status(201).json({ success: 1 })
                })
              })
            })
          })
      })
  })
})

app.post('/loginstudent', async (req, res) => {
    const { email,rollnumber, password } = req.body;
    const hashedPass = crypto.createHash('sha256').update(password).digest('hex');
    const query = `SELECT * from students WHERE rollnumber=? AND password=? AND email=?`;
    console.log(rollnumber,hashedPass)
    
        db.query(query,[rollnumber,hashedPass,email],(err,result) => {
          if(err){
            console.log(err);
            res.status(500).json({message:"Internal server error"})
          }
          else{
            if(result.length > 0){
              console.log("Student Logged in: " + result[0].username);
              const token = jwt.sign({
                  rollnumber,
                  type: "student"
              }, "secret", {
                  expiresIn: 60 * 60
              })
              res.status(201).json({success: true,token})
            }
            else{
              res.status(401).json({success:false})
            }
          }
        }) 
})

app.post('/registerstaff', async (req, res) => {
    const { teacher_id,teacher_name, password, email } = req.body;
    const hashedPass = crypto.createHash('sha256').update(password).digest('hex');
    const query = `INSERT INTO teachers(teacherId,teacher_name,password,email) VALUES(?,?,?,?)`;

    db.query(query,[teacher_id,teacher_name, hashedPass, email],(error,result) => {
      if(error){
        console.log(err);
        res.status(401).json({ success: 0 })
      }
      else{
        res.status(201).json({ success: 1 })
      }
    })
})

app.post('/loginstaff', async (req, res) => {
    const { teacherid,email, password } = req.body;
    const hashedPass = crypto.createHash('sha256').update(password).digest('hex');
    const query = `SELECT * from teachers WHERE email=? AND password=? AND teacherId = ?`;

    db.query(query,[email,hashedPass,teacherid],(error,result) => {
      if(error){
        res.status(500).json({ success: "Internal Server Error" })
      }
      else{
        if(result.length > 0){
          console.log("Staff Logged in: " + result[0].email);
  
          const token = jwt.sign({
              email,
              type: "staff"
          }, "secret", {
              expiresIn: 60 * 60
          })
          res.status(201).json({ success: true, token })
        }
        else{
          res.status(401).json({ success: false })
        }
      } 
    })
})

app.post('/loginadmin',async(req,res) => {
  const{adminemail,password} = req.body
  const hashedPass = crypto.createHash('sha256').update(password).digest('hex');
  const query = `SELECT * FROM admin WHERE email = ? AND password = ?`

  db.query(query,[adminemail,hashedPass],(error,result) => {
    if(error){
      res.status(500).json({ success: "Internal Server Error" })
    }
    else{
      if(result.length > 0){
        console.log("Admin Logged in: " + result[0].email);

        const token = jwt.sign({
            adminemail,
            type: "admin"
        }, "secret", {
            expiresIn: 60 * 60
        })
        res.status(201).json({ success: true, token })
      }
      else{
        res.status(401).json({ success: false })
      }
    } 
  })

})


app.post('/create-room', async (req, res) => {
    const body = req.body;
    const query1 = `INSERT INTO enrolledsubjects(student_roll_number,subjectid,teacher_email) VALUES(?,?,?)`;
    try {
        for (const obj of body) {
            await new Promise((resolve,reject) => {
              db.query(query1,[obj.rollnumber, obj.subject_code, obj.teacher_email],(error,result) => {
                if(error) reject (error)
                else resolve(result)
              })
            })
        }     
        
        res.status(201).json({ success: "Enrolled successdully" })
    }
    catch (err) {
        console.log(err)
        res.status(401).json({ success: "Failed to enroll" })
    }
})

app.post('/student-get-data', async (req, res) => {
    const { rollnumber } = req.body;
    const query1 = `SELECT teacher_email,subjectid from enrolledsubjects WHERE student_roll_number = ?`;
    const query2 = `SELECT subjectname,credits from subjects WHERE subjectid = ?`;
    const query3 = `SELECT teacher_name from teachers WHERE email = ?`
    try {
        const result1 = await new Promise((resolve,reject) => {
          db.query(query1,[rollnumber],(error,result) => {
            if(error) reject(error)
            else resolve(result)
          })
        })

        //const result1 = await db.query(query1, [rollnumber]);
        const data = []
        for (const row of result1) {
            const staff_email = row.teacher_email;
            const subject_code = row.subjectid;

            const result2 = await new Promise((resolve,reject) => {
              db.query(query2,[subject_code],(error,result) => {
                if(error) reject (error)
                else resolve(result)
              })
            })
            //const result2 = await db.query(query2, [subject_code]);
            const subject_name = result2[0].subjectname;
            const credit = result2[0].credits

            const result3 = await new Promise((resolve,reject) => {
              db.query(query3,[staff_email],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            //const result3 = await db.query(query3, [staff_email]);
            const staff_name = result3[0].teacher_name;

            data.push({ staff_name, subject_code, subject_name, credit,staff_email });
        }

        res.status(201).json(data);
    }
    catch (err) {
        console.log(err)
        res.status(401).json({ error: "Failed to fetch data" })
    }
})

app.post('/student-search-data', async (req, res) => {
  const { rollnumber, searchCode } = req.body;
  const query1 = `SELECT teacher_email,subjectid from enrolledsubjects WHERE student_roll_number = ? AND subjectid LIKE ?`;
  const query2 = `SELECT subjectname,credits from subjects WHERE subjectid = ?`;
  const query3 = `SELECT teacher_name from teachers WHERE email = ?`
  try {
      var stemp = "%";
      stemp += searchCode;
      stemp += "%";
      const result1 = await new Promise((resolve,reject) => {
        db.query(query1,[rollnumber,stemp],(error,result) => {
          if(error) reject(error)
          else resolve(result)
        })
      })

      //const result1 = await db.query(query1, [rollnumber]);
      const data = []
      for (const row of result1) {
          const staff_email = row.teacher_email;
          const subject_code = row.subjectid;

          const result2 = await new Promise((resolve,reject) => {
            db.query(query2,[subject_code],(error,result) => {
              if(error) reject (error)
              else resolve(result)
            })
          })
          //const result2 = await db.query(query2, [subject_code]);
          const subject_name = result2[0].subjectname;
          const credit = result2[0].credits

          const result3 = await new Promise((resolve,reject) => {
            db.query(query3,[staff_email],(error,result) => {
              if(error) reject(error)
              else resolve(result)
            })
          })
          //const result3 = await db.query(query3, [staff_email]);
          const staff_name = result3[0].teacher_name;

          data.push({ staff_name, subject_code, subject_name, credit,staff_email });
      }

      res.status(201).json(data);
  }
  catch (err) {
      console.log(err)
      res.status(401).json({ error: "Failed to fetch data" })
  }
})

app.post('/staff-get-data', async (req, res) => {
  const { email } = req.body;

  const query1 = `SELECT DISTINCT subjectid from enrolledsubjects WHERE teacher_email = ?`;
  const query2 = `SELECT subjectname, credits, Semester from subjects WHERE subjectid = ?`;

  try {
    const result1 = await new Promise((resolve, reject) => {
      db.query(query1, [email], (error, result) => {
        if (error) reject(error);
        else resolve(result);
      });
    });

    const data = [];
    for (const row of result1) {
      const subject_code = row.subjectid;
      const result2 = await new Promise((resolve, reject) => {
        db.query(query2, [subject_code], (error, result) => {
          if (error) reject(error);
          else resolve(result);
        });
      });
      const subject_name = result2[0].subjectname;
      const credits = result2[0].credits;
      const sem = result2[0].Semester;
      data.push({ subject_code, subject_name, credits, sem,email });
    }

    res.status(201).json(data);
  } catch (err) {
    console.error(err);
    res.status(401).json({ error: "Failed to fetch data" });
  }
});

app.post('/staff-search-data', async (req, res) => {
  const { email, searchCode } = req.body;
  const query1 = `SELECT DISTINCT subjectid from enrolledsubjects WHERE teacher_email = ? AND subjectid LIKE ?`;
  const query2 = `SELECT subjectname, credits, Semester from subjects WHERE subjectid = ?`;

  try {
    var stemp = "%";
    stemp += searchCode;
    stemp += "%";
    const result1 = await new Promise((resolve, reject) => {
      db.query(query1, [email,stemp], (error, result) => {
        if (error) reject(error);
        else resolve(result);
      });
    });

    const data = [];
    for (const row of result1) {
      const subject_code = row.subjectid;
      const result2 = await new Promise((resolve, reject) => {
        db.query(query2, [subject_code], (error, result) => {
          if (error) reject(error);
          else resolve(result);
        });
      });
      const subject_name = result2[0].subjectname;
      const credits = result2[0].credits;
      const sem = result2[0].Semester;
      data.push({ subject_code, subject_name, credits, sem });
    }

    res.status(201).json(data);
  } catch (err) {
    console.error(err);
    res.status(401).json({ error: "Failed to fetch data" });
  }
});


app.post('/student-room', async (req, res) => {
    const { staff_name, subject_code, subject_name, credit, rollnumber } = req.body;
    const query = `SELECT class_attended,class_taken FROM enrolledsubjects WHERE student_roll_number = ? AND subjectid = ?`;
    try {
        const result = await new Promise((resolve,reject) => {
          db.query(query,[rollnumber,subject_code],(error,result) => {
            if(error) reject(error)
            else resolve(result)
          })
        })
        //const result = await db.query(query, [rollnumber, subject_code]);
        const class_attended = result[0].class_attended;
        const class_taken = result[0].class_taken;
        res.status(201).json({ staff_name, subject_code, subject_name, credit, rollnumber, class_taken, class_attended });
    }
    catch (err) {
        console.log(err);
        res.status(401).json({ error: "Failed to fetch" })
    }
})

app.post('/get-staff-data', async (req, res) => {
    const { subject_code, subject_name, credits, email } = req.body;
    const query1 = `SELECT student_roll_number from enrolledsubjects WHERE subjectid = ? AND teacher_email = ? ORDER BY student_roll_number`;
    const query2 = `SELECT username from students WHERE rollnumber = ?`;
    const query3 = `SELECT class_attended,class_taken FROM enrolledsubjects WHERE student_roll_number = ? AND subjectid = ?`;
    const query4 = `select doc,attendance_status,num_of_hours from dates where  subject_code=? and staff_email=? and rollnumber=? and doc in (select doc from dates where subject_code=? and staff_email=? and rollnumber=?);`
    const data = []
    try {
        const result1 = await new Promise((resolve,reject) => {
          db.query(query1,[subject_code,email],(error,result) => {
            if(error) reject(error)
            else resolve(result)
          })
        })
        //const result1 = await db.query(query1, [subject_code, email]);
        for (const obj of result1) {
            const rollnumber = obj.student_roll_number;

            const result2 = await new Promise((resolve,reject) => {
              db.query(query2,[rollnumber],(error,result) => {
                if(error) reject (error)
                else resolve(result)
              })
            })
            //const result2 = await db.query(query2, [rollnumber]);
            const student_name = result2[0].username;

            const result3 = await new Promise((resolve,reject) => {
              db.query(query3,[rollnumber,subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            //const result3 = await db.query(query3, [rollnumber, subject_code]);
            const class_attended = result3[0].class_attended;
            const class_taken = result3[0].class_taken;
            
            //select doc,attendance_status from dates where  subject_code=? and staff_email=? and doc in (select doc from dates where subject_code=? and staff_email=? and rollnumber=?);`
            const dates = await new Promise((resolve, reject) => {
              db.query(query4,[subject_code,email,rollnumber,subject_code,email,rollnumber],(error, result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            console.log(dates)
            data.push({ subject_code, subject_name, credits, email, rollnumber, student_name, class_attended, class_taken, dates});
        }
        res.status(201).json(data);
    }
    catch (err) {
        console.log(err);
        res.status(401).json({ error: "Failed to fetch" })
    }
})

app.post('/attendance', async (req, res) => {
    const { selectedStudentsData, notSelectedStudentsData, numofhours, getdate } = req.body;
    console.log(req.body)
    const query1 = `SELECT class_taken,class_attended from enrolledsubjects WHERE student_roll_number = ? AND subjectid = ?`;
    const query2 = `UPDATE enrolledsubjects SET class_taken = ?, class_attended = ? WHERE student_roll_number = ? AND subjectid = ?`;
    const query3 = `INSERT into dates values(?,?,?,?,?,?)`;
    try {
        for (const obj of selectedStudentsData) {
            console.log(obj.rollnumber)
            const result1 = await new Promise((resolve,reject) => {
              db.query(query1,[obj.rollnumber,obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            console.log(result1)
            
            //const result1 = await db.query(query1, [obj.rollnumber, obj.subjectid]);

            
            const class_taken = result1[0].class_taken;
            const class_attended = result1[0].class_attended;

            await new Promise((resolve,reject) => {
              db.query(query2,[parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended) + parseInt(numofhours), obj.rollnumber, obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })

            await new Promise((resolve,reject) => {
              db.query(query3,[obj.rollnumber,obj.email,obj.subject_code,numofhours,'P',getdate],(error,result1) => {
                if(error) reject(error)
                else resolve(result1)
              })
            })
            //await db.query(query2, [parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended) + parseInt(numofhours), obj.rollnumber, obj.subjectid]);
        }
        for (const obj of notSelectedStudentsData) {
            const result1 = await new Promise((resolve,reject) => {
              db.query(query1,[obj.rollnumber,obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            //const result1 = await db.query(query1, [obj.rollnumber, obj.subjectid]);

            const class_taken = result1[0].class_taken;
            const class_attended = result1[0].class_attended;
            console.log(parseInt(class_taken) + parseInt(numofhours))
            
            await new Promise((resolve,reject) => {
              db.query(query2,[parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended) , obj.rollnumber, obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })

            await new Promise((resolve,reject) => {
              db.query(query3,[obj.rollnumber,obj.email,obj.subject_code,numofhours,'A',getdate],(error,result1) => {
                if(error) reject(error)
                else resolve(result1)
              })
            })
            //await db.query(query2, [parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended), obj.rollnumber, obj.subjectid]);
        }
        res.status(201).json({ success: "1" })
    }
    catch (err) {
        console.log(err);
        res.status(401).json({ success: "0" })
    }
})

app.post('/attendance1', async (req, res) => {
    const { presentStudentData, absentStudentData, numofhours,getdate } = req.body;
    console.log(getdate)
    const query1 = `SELECT class_taken,class_attended from enrolledsubjects WHERE student_roll_number = ? AND subjectid = ?`;
    const query2 = `UPDATE enrolledsubjects SET class_taken = ?, class_attended = ? WHERE student_roll_number = ? AND subjectid = ?`;
    const query3 = `INSERT into dates values(?,?,?,?,?,?)`;
    try {
        for (const obj of presentStudentData) {

            const result1 = await new Promise((resolve,reject) => {
              db.query(query1,[obj.rollnumber,obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            //const result1 = await db.query(query1, [obj.rollnumber, obj.subjectid]);

            const class_taken = result1[0].class_taken;
            const class_attended = result1[0].class_attended;

            await new Promise((resolve,reject) => {
              db.query(query2,[parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended) + parseInt(numofhours), obj.rollnumber, obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })

            await new Promise((resolve,reject) => {
              db.query(query3,[obj.rollnumber,obj.email,obj.subject_code,numofhours,'P',getdate],(error,result1) => {
                if(error) reject(error)
                else resolve(result1)
              })
            })
            //await db.query(query2, [parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended) + parseInt(numofhours), obj.rollnumber, obj.subjectid]);
        }
        for (const obj of absentStudentData) {

            const result1 = await new Promise((resolve,reject) => {
              db.query(query1,[obj.rollnumber, obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            //const result1 = await db.query(query1, [obj.rollnumber, obj.subjectid]);

            const class_taken = result1[0].class_taken;
            const class_attended = result1[0].class_attended;
            console.log(parseInt(class_taken) + parseInt(numofhours))
            await new Promise((resolve,reject) => {
              db.query(query2,[parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended), obj.rollnumber, obj.subject_code],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })

            await new Promise((resolve,reject) => {
              db.query(query3,[obj.rollnumber,obj.email,obj.subject_code,numofhours,'A',getdate],(error,result1) => {
                if(error) reject(error)
                else resolve(result1)
              })
            })
            res.status(201).json({ success: "1" })
            //await db.query(query2, [parseInt(class_taken) + parseInt(numofhours), parseInt(class_attended), obj.rollnumber, obj.subjectid]);
        }
       
    }
    catch (err) {
        console.log(err);
        res.status(401).json({ success: "0" })
    }
})

app.post('/attendance-view', async (req, res) => {
    const { subject_code, email } = req.body;
    const query1 = `SELECT class_taken from enrolledsubjects WHERE subjectid = ? AND teacher_email = ?`;
    try {
        const result = await new Promise((resolve,reject) => {
          db.query(query1,[subject_code,email],(error,result) => {
            if(error) reject(error)
            else resolve(result)
          })
        })
        //const result = await db.query(query1, [subject_code, email]);
        const class_taken = result[0];
        res.status(201).json({ class_taken: class_taken })
    }
    catch (err) {
        res.status(401).json({ message: "Error in viewing" })
    }
})

app.post('/search/:id', async (req, res) => {
    const { email, subjectcode } = req.body;
    //console.log(req.body)
    const query1 = `SELECT username,rollnumber from students WHERE rollnumber LIKE ? AND rollnumber in (SELECT student_roll_number from enrolledsubjects WHERE teacher_email=? AND subjectid=?)`;
    const query2 = `SELECT class_taken,class_attended from enrolledsubjects WHERE student_roll_number = ? AND teacher_email = ? AND subjectid = ?`;
    const query3 = `select doc,attendance_status from dates where  subject_code=? and staff_email=? and rollnumber=? and doc in (select doc from dates where subject_code=? and staff_email=? and rollnumber=?);`
    const data = []
    try {
        const roll = req.params.id;
        var rtemp = "%";
        rtemp += roll;
        rtemp += "%";
        // console.log(rtemp)
        const result1 = await new Promise((resolve,reject) => {
          db.query(query1,[rtemp,email,subjectcode],(error,result) => {
            if(error) reject(error)
            else resolve(result)
          })
        })
        console.log(result1)
        //const result1 = await db.query(query1, [rtemp, email, subjectcode]);

        var t = 0;

        for (const obj of result1) {
            t = 1;
            const student_name = obj.username;
            const rollnumber = obj.rollnumber;

            const result2 = await new Promise((resolve,reject) => {
              db.query(query2,[rollnumber,email,subjectcode],(error,result) => {
                if(error) reject(error)
                else resolve(result)
              })
            })
            //const result2 = await db.query(query2, [rollnumber, email, subjectcode]);
            const class_taken = result2[0].class_taken
            const class_attended = result2[0].class_attended

            //select doc,attendance_status from dates where  subject_code=? and staff_email=? and rollnumber=? and doc in (select doc from dates where subject_code=? and staff_email=? and rollnumber=?);`
            const dates = await new Promise((resolve,reject) => {
              db.query(query3,[subjectcode,email,rollnumber,subjectcode,email,rollnumber],(error,result) => {
                if(error) reject(error)
                  else resolve(result)
              })
            })

            data.push({ rollnumber, student_name, subjectcode, email, class_taken, class_attended,dates });
        }

        if (t == 1) {
            res.status(201).json(data);
        }
        else {
            res.status(201).json([]);
        }

    }
    catch (err) {
        res.status(401).json({ message: "Internal server error" })
    }
})

const myemail = process.env.API_URL
const mypassword = process.env.API_PASS

let transporter = nodemailer.createTransport({
  service: 'Gmail',
  auth: {
    user: `${myemail}`,
    pass: `${mypassword}`
  }
});

app.post('/getstudentemail', async (req, res) => {
  const { rollnumber } = req.body;
  const query1 = `SELECT email FROM students WHERE rollnumber = ?`;
  try {
      const result1 = await new Promise((resolve, reject) => {
          db.query(query1, [rollnumber], (error, result) => {
              if (error) reject(error);
              else resolve(result);
          });
      });
      if (result1.length > 0) {
          const email = result1[0].email; // Access email from the first object in the array
          console.log(email);
          res.status(200).json({ email });
      } else {
          res.status(404).json({ message: "Email not found for given rollnumber" });
      }
  } catch (err) {
      console.log(err);
      res.status(500).json({ message: "Internal server error" });
  }
});


app.post('/sendmail',async(req,res) => {
  const obj = req.body;
  for(let i=0;i<obj.length;i++) {
    const data = obj[i]
    let mailOptions = {
      from: data.from ,
      to:data.to,
      subject: "Regarding attendance",
      text: "Attendance",
      html:`<b>${data.text}</b>`
    };
    
    transporter.sendMail(mailOptions, (error,info) => {
      if (error) {
          console.log(error);
          res.status(500).json({message:"Internal server error"})
        } else {
          console.log('Email sent:'+ info.messageId);
          res.status(200).json({message:"success"})
        }
    })
  }
  
})

let passwordResetTokens = {}

app.post('/forgotpassword',async(req,res) => {
  const {email,role} = req.body
  const token = crypto.randomBytes(20).toString('hex');
  passwordResetTokens[token] = email


  const mailOptions = {
    from: `${myemail}`,
    to: email,
    subject: "Reset Password",
    text: `Click this link to reset your password: http://localhost:3000/reset-password/${role}/${token}`
  }


  transporter.sendMail(mailOptions),(error,info) => {
    if(error){
      res.status(500).json({message:"Failed to send password reset email"})
    }
    else{
      res.status(200).json({message:"Password reset email sent"})
    }
  }

})

app.post('/passwordreset',async(req,res) => {
  const {token,role,newPassword} = req.body
  const hashedPass = crypto.createHash('sha256').update(newPassword).digest('hex');
  const email=passwordResetTokens[token]
  if(email){
    let query1;
    if(role == "staff"){
      query1 = 'UPDATE teachers SET password = ? WHERE email = ?'; 
    }
    else if(role == "student"){
      query1 = 'UPDATE students SET password = ? WHERE email = ?';
    }
    try{
      const result1 = await new Promise((resolve, reject) => {
        db.query(query1, [hashedPass, email], (error, result) => {
          if (error) reject(error);
          else resolve(result);
        });
      })
      delete passwordResetTokens[token]
      res.status(200).json({message: "Success"})
    }
    catch(error){
      res.status(400).json({message:"Invalid token"})
    }
   
  }
  else{
    res.status(500).json({message:"Bad request"})
  }
  
})

app.get('/get-stafflist',async(req,res) => {
  const query = `SELECT teacherid,teacher_name,email FROM teachers`;
  try{
    const stafflist = await new Promise((resolve, reject) => {
      db.query(query,(error,result) => {
        if(error) reject(error)
        else resolve(result)
      })
    })
    if(stafflist.length > 0){
      res.status(200).json(stafflist)
    }
    else{
      res.status(200).json([])
    }
  }
  catch(err){
    console.log(err)
    res.status(500).json({message:"Internal server error"})
  }
})

app.post('/search-stafflist',async(req,res) => {
  const {teacher_name} = req.body
  const query = `SELECT teacherid,teacher_name,email FROM teachers WHERE teacher_name LIKE ?`;
  try{
    var ntemp = "%";
    ntemp += teacher_name;
    ntemp += "%";
    const stafflist = await new Promise((resolve, reject) => {
      db.query(query,[ntemp],(error,result) => {
        if(error) reject(error)
        else resolve(result)
      })
    })
    if(stafflist.length > 0){
      res.status(200).json(stafflist)
    }
    else{
      res.status(200).json([])
    }
  }
  catch(err){
    console.log(err)
    res.status(500).json({message:"Internal server error"})
  }
})


const storage=multer.diskStorage(
    {
      destination: (req, file, cb) => {
        const directory ='prof-image/'+ path.dirname(file.originalname);
        cb(null, directory);
      },
      filename: (req, file, cb) => {
        cb(null, file.fieldname+"_"+Date.now()+path.extname(file.originalname));
      }
    }
  )
  const upload=multer({
    storage:storage
  })
  
  
  app.post('/upload/:RollNumber',upload.single('image'),(req,res)=>{
    const {RollNumber}=req.params;
    const image=req.file.filename;
    const sql1="update studentdetails set StudentImage=? where RollNumber=?";
    db.query(sql1,[image,RollNumber],(err,result)=>{
      if(err) return res.json({message:"Error"});
      console.log("upload",result);
      return res.json({status:"Success"});
    })
  })
  
  
  app.get('/getImage/:RollNumber', (req, res) => {
    const { RollNumber } = req.params;
  
    const sql1 = "SELECT StudentImage FROM studentdetails WHERE RollNumber=?";
    db.query(sql1, [RollNumber], (err, result) => {
      if (err) return res.json({ message: "Error" });
  
      if (result.length === 0) {
        return res.json({ message: "Image not found" });
      }
      let imageName = result[0].StudentImage || 'default.jpg';
  
      const imagePath = path.join(__dirname, 'prof-image', imageName);
  
      if (!fs.existsSync(imagePath)) {
        return res.json({ message: "Image not found" });
      }
      fs.readFile(imagePath, (err, data) => {
        if (err) {
          console.error('Error reading image file:', err);
          return res.json({ message: "Error reading image file" });
        }
        res.writeHead(200, { 'Content-Type': 'image/*' });
        res.end(data);
      });
    });
  });
  
  
  
  
  
  
  
  app.get('/studentdetails/:username', (req, res) => {
    const { username } = req.params;
    console.log('studentdetails:', username);
    const sql = 'SELECT * FROM studentdetails WHERE RollNumber = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
        res.json(result[0]); 
    });
  });
  
  app.get('/InternshipDetails/:username', (req, res) => {
    const { username } = req.params;
    const sql = 'SELECT internship.*, studentdetails.Name, studentdetails.Phone FROM internship  INNER JOIN studentdetails ON internship.roll_number = studentdetails.RollNumber WHERE internship.roll_number = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
        res.json(result); 
    });
  });
  
  app.get('/ScholarshipDetails/:username', (req, res) => {
    const { username } = req.params;
    const sql = 'SELECT scholarship.*, studentdetails.Name, studentdetails.Phone FROM scholarship INNER JOIN studentdetails ON scholarship.roll_number = studentdetails.RollNumber WHERE scholarship.roll_number = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
        res.json(result); 
    });
  });
  
  app.get('/ProjectDetails/:username', (req, res) => {
    const { username } = req.params;
    const sql = 'SELECT project.*, studentdetails.Name, studentdetails.Phone FROM project INNER JOIN studentdetails ON project.roll_number = studentdetails.RollNumber WHERE project.roll_number = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
        res.json(result); 
    });
  });
  
  
  app.get('/SportsDetails/:username', (req, res) => {
    const { username } = req.params;
    const sql = 'SELECT sports.*, studentdetails.Name, studentdetails.Phone FROM sports INNER JOIN studentdetails ON sports.roll_number = studentdetails.RollNumber WHERE sports.roll_number = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
        res.json(result); 
    });
  });
  
  app.get('/ExamsDetails/:username', (req, res) => {
    const { username } = req.params;
    const sql = 'SELECT * FROM exams_attended WHERE roll_number = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
        res.json(result); 
    });
  });
  
  app.get('/PaperDetails/:username', (req, res) => {
    const { username } = req.params;
    const sql = 'SELECT paper_published.*, studentdetails.Name, studentdetails.Phone FROM paper_published INNER JOIN studentdetails ON paper_published.roll_number = studentdetails.RollNumber WHERE paper_published.roll_number = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
       
        res.json(result); 
    });
  });
  
  app.get('/EventDetails/:username', (req, res) => {
    const { username } = req.params;
    const sql = 'SELECT events.*, studentdetails.Name, studentdetails.Phone FROM events INNER JOIN studentdetails ON events.roll_number = studentdetails.RollNumber WHERE events.roll_number = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            throw err;
        }
        res.json(result); 
    });
  });
  
  
  app.put('/updatestudentdetails/:username', (req, res) => {
    const { username } = req.params;
    const updatedData = req.body;
    console.log("data add",updatedData.FatherName);
    const sql = 'UPDATE studentdetails SET Name=?, DateOfBirth = ?, Address = ?, Phone = ?,Sex=?,Blood_Group=?,FatherName=?,MotherName=?,Fatheroccupation=?,Motheroccupation=?,Residenttype=?,Fathermobile=?,Mothermobile=? WHERE RollNumber = ?';
    db.query(sql, [updatedData.Name, updatedData.DateOfBirth, updatedData.Address, updatedData.Phone,updatedData.Sex,updatedData.Blood_Group,updatedData.FatherName,updatedData.Mothername,updatedData.Fatheroccupation,updatedData.Motheroccupation,updatedData.Residenttype,updatedData.Fathermobile,updatedData.Mothermobile, username], (err, result) => {
        if (err) {
            throw err;
        }
        console.log(result);
        res.send('Student details updated successfully');
    });
  });
  
  
  app.post('/addstudentdetails/:rollNumber', (req, res) => {
    const {rollNumber} = req.params;
    const newStudentData = req.body;
    const checkExistingQuery = 'SELECT * FROM studentdetails WHERE RollNumber = ?';
    db.query(checkExistingQuery, [rollNumber], (checkError, checkResult) => {
        if (checkError) {
            throw checkError;
        }
        if (checkResult.length === 0) {
            const insertQuery = 'INSERT INTO studentdetails (RollNumber, Name, DateOfBirth, Residenttype, Address, Phone, Sex, Blood_Group, FatherName, Fathermobile, Mothername, Mothermobile, Fatheroccupation, Motheroccupation) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
            const insertValues = [
                rollNumber,
                newStudentData.Name,
                newStudentData.DateOfBirth,
                newStudentData.Residenttype,
                newStudentData.Address,
                newStudentData.Phone,
                newStudentData.Sex,
                newStudentData.Blood_Group,
                newStudentData.FatherName,
                newStudentData.Fathermobile,
                newStudentData.Mothername,
                newStudentData.Mothermobile,
                newStudentData.Fatheroccupation,
                newStudentData.Motheroccupation
            ];
  
            db.query(insertQuery, insertValues, (insertError, insertResult) => {
                if (insertError) {
                    throw insertError;
                }
                res.send('Student details added successfully');
            });
        } else {
            res.status(400).send('Student with this RollNumber already exists');
        }
    });
  });
  
  
  
  
  app.delete('/deleteScholarship/:id', (req, res) => {
    const id = req.params.id;
    const sql = 'DELETE FROM scholarship WHERE id =?';
    db.query(sql, [id], (err, result) => {
        if (err) {
            throw err;
        }
        res.send('Scholarship deleted successfully');
    });
  })
  
  app.delete('/deleteInternship/:id', (req, res) => {
    const id = req.params.id;
    const sql = 'DELETE FROM internship WHERE id =?';
    db.query(sql, [id], (err, result) => {
        if (err) {
            throw err;
        }
        res.send('Internship deleted successfully');
    });
  })
  
  app.delete('/deleteProject/:id', (req, res) => {
    const id = req.params.id;
    const sql = 'DELETE FROM project WHERE id =?';
    db.query(sql, [id], (err, result) => {
        if (err) {
            throw err;
        }
        res.send('Project deleted successfully');
    });
  })
  
  app.delete('/deleteSports/:id', (req, res) => {
    const id = req.params.id;
    const sql = 'DELETE FROM sports WHERE id =?';
    db.query(sql, [id], (err, result) => {
        if (err) {
            throw err;
        }
        res.send('Sports deleted successfully');
    });
  })
  
  app.delete('/deletePapers/:id', (req, res) => {
    const id = req.params.id;
    const sql = 'DELETE FROM paper_published WHERE id =?';
    db.query(sql, [id], (err, result) => {
        if (err) {
            throw err;
        }
        res.send('Papers deleted successfully');
    });
  })
  
  app.delete('/deleteEvents/:id', (req, res) => {
    const id = req.params.id;
    const sql = 'DELETE FROM events WHERE id =?';
    db.query(sql, [id], (err, result) => {
        if (err) {
            throw err;
        }
        res.send('Events deleted successfully');
    });
  })
  
  
  app.post('/addScholarship/:roll_number', (req, res) => {
    const {roll_number}=req.params;
    const scholarshipData = req.body;
    const sql = 'INSERT INTO scholarship (roll_number,ScholarshipProvider, amount) VALUES (?,?, ?)';
    db.query(sql, [roll_number,scholarshipData.ScholarshipProvider, scholarshipData.amount], (err, result) => {
        if (err) {
            console.error('Error adding scholarship data:', err);
            res.status(500).json({ error: 'Failed to add scholarship data to database' });
        } else {
            console.log('Scholarship data added successfully');
            res.status(200).json({ message: 'Scholarship data added successfully' });
        }
    });
  });
  
  app.post('/addProject/:roll_number', (req, res) => {
    const {roll_number}=req.params;
    const projectData = req.body;
    const sql = 'INSERT INTO project (roll_number,title,guide,project_desc) VALUES (?,?, ?,?)';
    db.query(sql, [roll_number,projectData.title,projectData.guide,projectData.project_desc], (err, result) => {
        if (err) {
            console.error('Error adding Project data:', err);
            res.status(500).json({ error: 'Failed to add Project  data to database' });
        } else {
            console.log('Project data added successfully');
            res.status(200).json({ message: 'Project  data added successfully' });
        }
    });
  });
  
  app.post('/addInternship/:roll_number', (req, res) => {
    const { roll_number } = req.params;
    const internshipData = req.body;
    const sql = 'INSERT INTO internship (roll_number, employer_name, on_off_campus, ctc, InternshipDuration, InternshipStartDate, InternshipEndDate, product_service_based) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
    db.query(sql, [roll_number, internshipData.employer_name, internshipData.on_off_campus, internshipData.ctc, internshipData.InternshipDuration, internshipData.InternshipStartDate, internshipData.InternshipEndDate, internshipData.product_service_based], (err, result) => {
      if (err) {
        console.error('Error adding Internship data:', err);
        res.status(500).json({ error: 'Failed to add Internship data to database' });
      } else {
        console.log('Internship data added successfully');
        res.status(200).json({ message: 'Internship data added successfully' });
      }
    });
  });
  app.post('/addSport/:roll_number', (req, res) => {
    const { roll_number } = req.params;
    const sportsData = req.body;
    const sql = 'INSERT INTO sports (roll_number, event_name, award) VALUES (?, ?, ?)';
    db.query(sql, [roll_number, sportsData.event_name, sportsData.award], (err, result) => {
      if (err) {
        console.error('Error adding Sports data:', err);
        res.status(500).json({ error: 'Failed to add Sports data to database' });
      } else {
        console.log('Sports data added successfully');
        res.status(200).json({ message: 'Sports data added successfully' });
      }
    });
  });
  
  app.post('/addPaper/:roll_number', (req, res) => {
    console.log('addpaper');
    const { roll_number } = req.params;
    const paperData = req.body;
    const sql = 'INSERT INTO paper_published (roll_number, title, journal, date_year, DOI_link) VALUES (?, ?, ?, ?, ?)';
    db.query(sql, [roll_number, paperData.title, paperData.journal, paperData.date_year, paperData.DOI_link], (err, result) => {
      if (err) {
        console.error('Error adding Paper Published data:', err);
        res.status(500).json({ error: 'Failed to add Paper Published data to database' });
      } else {
        console.log('Paper Published data added successfully');
        res.status(200).json({ message: 'Paper Published data added successfully' });
      }
    });
  });
  
  app.post('/addEvent/:roll_number', (req, res) => {
    const { roll_number } = req.params;
    const eventData = req.body;
    const sql = 'INSERT INTO events (roll_number, event_name, institution, date, role, awards) VALUES (?, ?, ?, ?, ?, ?)';
    db.query(sql, [roll_number, eventData.event_name, eventData.institution, eventData.date, eventData.role, eventData.awards], (err, result) => {
      if (err) {
        console.error('Error adding Event data:', err);
        res.status(500).json({ error: 'Failed to add Event data to database' });
      } else {
        console.log('Event data added successfully');
        res.status(200).json({ message: 'Event data added successfully' });
      }
    });
  });
  
  
  app.get('/basicacademic/:rollNumber', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const query = `SELECT * FROM student_academic_details WHERE RollNumber = ?`;
    db.query(query, [rollNumber], (error, results) => {
      if (error) {
        console.error('Error executing query: ', error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      if (results.length === 0) {
        res.status(404).json({ message: 'Student academic details not found' });
        return;
      }
      res.json(results[0]);
    });
  });
  
  app.get('/getsemestermarks/:rollNumber/:sem', (req, res) => {
    const semester = req.params.sem;
    const rollNumber = req.params.rollNumber;
    console.log(semester, rollNumber);
    const query = `SELECT *,
                  subjects.SubjectName,
                  subjects.credits,
                  (
                      SELECT AVG(MarksObtained)
                      FROM marks AS m
                      WHERE m.SubjectID = marks.SubjectID
                  ) AS AverageMark,
                  (
                      SELECT MAX(MarksObtained)
                      FROM marks AS m
                      WHERE m.SubjectID = marks.SubjectID
                  ) AS MaximumMark
                  FROM marks
                  INNER JOIN subjects ON marks.SubjectID = subjects.SubjectID
                  WHERE marks.Semester = ? AND marks.RollNumber = ?
                  ORDER BY subjects.credits;`;
    db.query(query, [semester, rollNumber], (error, results) => {
      if (error) throw error;

      res.json(results);
    });
  });
  app.put('/editmarks/:rollNumber/:subjectID', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const subjectID = req.params.subjectID;
    const newMarks = req.body.marks;
    const query = `UPDATE marks SET MarksObtained = ? WHERE RollNumber = ? AND SubjectID = ?`;
    db.query(query, [newMarks, rollNumber, subjectID], (error, results) => {
      if (error) {
        console.error("Error updating marks:", error);
        res.status(500).json({ error: "An error occurred while updating marks" });
      } else {
        console.log("Marks and grade updated successfully");
        res.status(200).json({ message: "Marks and grade updated successfully" });
      }
    });
  });

  app.put('/editgrade/:rollNumber/:subjectID', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const subjectID = req.params.subjectID;
    const newgrade = req.body.grade;
    const query = `UPDATE marks SET Grade = ? WHERE RollNumber = ? AND SubjectID = ?`;
    db.query(query, [newgrade, rollNumber, subjectID], (error, results) => {
      if (error) {
        console.error("Error updating grade:", error);
        res.status(500).json({ error: "An error occurred while updating grade" });
      } else {
        console.log(" grade updated successfully");
        res.status(200).json({ message: "grade updated successfully" });
      }
    });
  });
  
  
  app.get('/getsemestergpa/:rollNumber/:sem', (req, res) => {
    const semester = req.params.sem;
    const rollNumber = req.params.rollNumber;
    console.log(semester, rollNumber);
    const query = `SELECT * FROM gpa WHERE semester =? AND rollnumber =?`;
    db.query(query, [semester, rollNumber], (error, results) => {
      if (error) throw error;
      res.json(results[0]);
    });
  })

  app.get('/getcgpa/:rollNumber/', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const query = `SELECT sum(gpa)/count(gpa) AS cgpa FROM gpa WHERE gpa!=0 AND rollnumber=?`;
    db.query(query, [rollNumber], (error, results) => {
      if (error) throw error;
      console.log("Fetched cgpa", results[0])
      res.json(results[0]);
    });
  })
  
  app.put('/editbasicacademic/:rollNumber', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const { CurrentSemester, TenthMarks, HigherSecondaryMarks, Cutoff } = req.body;
    const query = `UPDATE student_academic_details 
                   SET CurrentSemester = ?, TenthMarks = ?, HigherSecondaryMarks = ?, Cutoff = ? 
                   WHERE RollNumber = ?`;
    
    db.query(query, [CurrentSemester, TenthMarks, HigherSecondaryMarks, Cutoff, rollNumber], (error, results) => {
        if (error) {
            console.error("Error updating basic academic details:", error);
            res.status(500).json({ error: "An error occurred while updating basic academic details" });
        } else {
            console.log("Basic academic details updated successfully");
            res.status(200).json({ message: "Basic academic details updated successfully" });
        }
    });
  });
  app.get('/getgpa/:rollNumber', (req, res) => {
    const rollNumber = req.params.rollNumber;
    console.log(rollNumber);
    const query = `SELECT * FROM gpa WHERE rollnumber =? and gpa!=0`;
    db.query(query, [rollNumber], (error, results) => {
      if (error) throw error;
      res.json(results);
    }); 
  })
  app.get('/getverifystatus/:rollNumber/:sem', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const sem = req.params.sem;
  
    // Query to fetch verify_status for the given rollNumber and semester
    const query = `
      SELECT 
        IF(COUNT(*) = SUM(verified_status), TRUE, FALSE) AS all_verified 
      FROM 
        marks 
      WHERE 
        RollNumber = ? AND 
        Semester = ?
    `;
  
    // Execute the query
    db.query(query, [rollNumber, sem], (error, results) => {
      if (error) {
        console.error('Error executing MySQL query: ' + error.stack);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      // Extracting the result
      const allVerified = results[0].all_verified;
      console.log(allVerified);
      // Sending the response
      res.json({ allVerified });
    });
  });
  
  app.get('/approve/:rollNumber/:sem', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const sem = req.params.sem;
    const query = `
      UPDATE marks 
      SET verified_status = TRUE 
      WHERE RollNumber = ? AND Semester = ?
    `;
    db.query(query, [rollNumber, sem], (error, results) => {
      if (error) {
        console.error('Error executing MySQL query: ' + error.stack);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      if (results.affectedRows === 0) {
        res.status(404).json({ error: 'No matching record found' });
        return;
      }
      res.json({ message: 'Verification status updated successfully' });
    });
  });
  
  app.get('/unapprove/:rollNumber/:sem', (req, res) => {
    const rollNumber = req.params.rollNumber;
    const sem = req.params.sem;
    const query = `
      UPDATE marks 
      SET verified_status = FALSE 
      WHERE RollNumber = ? AND Semester = ?
    `;
    db.query(query, [rollNumber, sem], (error, results) => {
      if (error) {
        console.error('Error executing MySQL query: ' + error.stack);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      if (results.affectedRows === 0) {
        res.status(404).json({ error: 'No matching record found' });
        return;
      }
      res.json({ message: 'Verification status updated successfully' });
    });
  });


  app.get('/getstafflist', (req, res) => {
    const query = `SELECT teacherId,teacher_name from teachers`;
    db.query(query, (error, results) => {
      if (error) {
        console.error('Error executing MySQL query: ' + error.stack);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.json(results);
    });
  })


  app.get('/getstaffsubjects/:teacherId', (req, res) => {
    
    
    {const teacherId = req.params.teacherId;
    const query0 = `SELECT email FROM teachers WHERE teacherId = ?`;
    db.query(query0, [teacherId], (error, results0) => {
      
      if (error) {
        console.error('Error executing MySQL query: ' + error.stack);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      if(results0.length==0){
        console.log('error in email')
        return;
      }
      // Assuming results0 is an array with a single object containing the teacher's email
     
      const teacherEmail = results0[0].email;
      const query = `SELECT DISTINCT subjectid FROM enrolledsubjects WHERE teacher_email = ?`;
      db.query(query, [teacherEmail], (error, results) => {
        if (error) {
          console.error('Error executing MySQL query: ' + error.stack);
          res.status(500).json({ error: 'Internal server error' });
          return;
        }
        const subjectIds = results.map(result => result.subjectid);
        const placeholders = subjectIds.map(() => '?').join(',');
        const query2 = `SELECT SubjectId, SubjectName FROM subjects WHERE SubjectId IN (${placeholders})`;
        db.query(query2, subjectIds, (error, results1) => {
          if (error) {
            console.error('Error executing MySQL query: ' + error.stack);
            res.status(500).json({ error: 'Internal server error' });
            return;
          }
          console.log(results1)
          res.json(results1);
        })
      })
    })
  }
}
)

  

  app.get('/getstaffsubjectmarks', (req, res) => {
    
  })


  app.post('/calculategpa/:rollnumber/:sem', (req, res) => {
    const rollNumber=req.params.rollnumber;
    const semester=req.params.sem;
    console.log(rollNumber, semester);
    const query = `
      SELECT m.MarksObtained, m.Grade, s.credits
      FROM marks m
      INNER JOIN subjects s ON m.SubjectID = s.SubjectID
      WHERE m.RollNumber = ? AND m.Semester = ?
    `;
    db.query(query, [rollNumber, semester], (error, results) => {
      if (error) {
        console.error('Error querying database: ' + error.stack);
        return res.status(500).json({ error: 'Internal Server Error' });
      }
      let totalCredits = 0;
      let totalPoints = 0;
      var isfailed = false;
      results.forEach(row => {
        totalCredits += row.credits;
        switch (row.Grade) {
          case 'O':
            totalPoints += 10 * row.credits;
            break;
          case 'A+':
            totalPoints += 9 * row.credits;
            break;
          case 'A':
            totalPoints += 8 * row.credits;
            break;
          case 'B+':
            totalPoints += 7 * row.credits;
            break;
          case 'B':
            totalPoints += 6 * row.credits;
            break;
          default:
            isfailed = true;
            totalPoints=0;
            break;
        }
      });
      if(isfailed){
        totalPoints=0;
      }
    const gpa = (totalPoints / totalCredits).toFixed(2);
    const checkQuery = `SELECT * FROM gpa WHERE rollnumber=? AND semester=?`;

    db.query(checkQuery, [rollNumber, semester], (error, results) => {
    if (error) {
        console.error('Error executing MySQL query: ' + error.stack);
        res.status(500).json({ error: 'Internal server error' });
        return;
    }

    if (results.length > 0) {
        // Record exists, execute the UPDATE query
        const updateQuery = `UPDATE gpa SET gpa=? WHERE rollnumber=? AND semester=?`;

        db.query(updateQuery, [gpa, rollNumber, semester], (updateError, updateResult) => {
          if (updateError) {
              console.error('Error executing MySQL update query: ' + updateError.stack);
              res.status(500).json({ error: 'Internal server error' });
              return;
          }

          res.status(200).json({ message: 'Record updated successfully' , gpa: gpa});
        });
    }
          else {
            // Record does not exist, execute the INSERT query
            const insertQuery = `INSERT INTO gpa (rollnumber, gpa, semester) VALUES (?, ?, ?)`;
            console.log("GPA")
            console.log(gpa)
            db.query(insertQuery, [rollNumber, gpa, semester], (insertError, insertResult) => {
                if (insertError) {
                    console.error('Error executing MySQL insert query: ' + insertError.stack);
                    res.status(500).json({ error: 'Internal server error' });
                    return;
                }

                res.status(200).json({ message: 'Record inserted successfully' , gpa: gpa});
            });
          }   
});

      //res.json({ gpa });
      console.log(gpa)
    });
  });


app.get('/getstudentlist/:teacherid/:subjectid',(req, res) =>{
const teacherid = req.params.teacherid;
const subjectid = req.params.subjectid;

const query0=`select * from marks where SubjectID=? and teacherId=? `;
db.query(query0,[subjectid, teacherid],(error,result)=>{
  if(error){
    console.error('Error executing MySQL query: ' + error.stack);
    res.status(500).json({ error: 'Internal server error' });
    return
  }
  console.log('student lsit',result);
  res.json(result);
})
})

app.get('/getstudentstatistics/:teacherid/:subjectid',(req,res)=>{
  const teacherid = req.params.teacherid;
const subjectid = req.params.subjectid;

const query=`SELECT 
AVG(MarksObtained) AS average_mark,
MAX(MarksObtained) AS max_mark
FROM 
marks
WHERE 
SubjectID = ? AND teacherId = ?;
`;

db.query(query,[subjectid, teacherid],(error,result)=>{
  if(error){
    console.error('Error executing MySQL query: ' + error.stack);
    res.status(500).json({ error: 'Internal server error' });
    return
  }
  console.log('student statistics',result);
  res.json(result);
})

})


