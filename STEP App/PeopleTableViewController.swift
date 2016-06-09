//
//  PeopleTableViewController.swift
//  STEP App
//
//  Created by Osaze Shears on 3/10/15.
//  Copyright (c) 2015 OSApps. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var people:[Person] =
    [
        Person(name:"Jermaine Azu", bio:"Hello STEP 2016! My name is Jermaine Azu, and I cannot wait to be one of your mentors this summer! I was born in Alexandria, Virginia and I am culturally from Ghana on the West Coast of Africa. I am a Junior here at George Mason majoring in Electrical Engineering. On campus, I am involved as a Peer Advisor, Resident Advisor and as a student staff member of ODIME. In my free time I work out, play sports and watch movies. I also have the hobby of writing and recording music. I am so excited to meet every single one of you. I was a student in the STEP 2014 program, and I believe you will love every minute of it. It is an honor going through this experience with you all.", image:"jermaine", role:"STEP 2016 Mentor"),
        Person(name:"Kayla Peterson", bio:"Hey there! My name is Kayla Peterson, and I am a rising junior, hailing from Middletown, Delaware. I am studying Sociology concentrating in Social Justice and Inequality. This semester I will be declaring minors in Immigration Studies and Spanish. During my time at Mason, I have been involved with Honors College Black Ambition (HCBA), dancing with the Nepalese Student Association, Alternative Break, and assisting my professor with research. This year I am Education Chairperson for HCBA and a Resident Advisor. I try to fill my days with laughter and smiles, which usually come from late nights goofing around, singing and dancing with friends. I am elated to meet each one of you and being a part of your college journey. Let’s make this summer the best!", image:"kayla", role:"STEP 2016 Mentor"),
        Person(name:"Ana Tobar-Romero", bio:"Hello STEP class of 2016! My name is Ana Tobar, and I am very excited to be working with you all this upcoming summer! I am a rising senior double majoring in Communication and Global Affairs. A little bit about me: I was born in El Salvador, I absolutely love food, traveling and I spend a lot of my free time working out and exploring anything and everything around me! On campus, I am the Internal President of Mason DREAMers, a Resident Advisor, Mason Ambassador and the Apple Campus Representative. I am eager to be able to share all the knowledge I have gained through my experience at Mason and pass it on to you all during STEP. This summer will definitely be one you won’t forget, and I can’t wait to meet each and every single one of you!", image:"ana", role:"STEP 2016 Mentor"),
        Person(name:"Faysal Shaikh", bio:"Hi everyone! My name is Faysal Shaikh, and I am a rising junior at George Mason University from Manassas Park, VA. I am pursuing a program of study with double- majors in Neuroscience and in Computational & Data Sciences! I am also a member of the Honors College at Mason, and am myself a STEP 2014 Scholar! I have been involved in the Mason community in various ways so far, but specifically for this upcoming year I am a Head Resident Advisor, Vice President of Mason Science Slam, Undergraduate Liaison for Students in Neuroscience, Student Researcher at the Krasnow Institute for Advanced Study, Webmaster for Mason Quiz Bowl, and one of your STEP Mentors for STEP 2016! I cannot wait to meet you all, and I am very excited to be working with you this summer!", image:"faysal", role:"STEP 2016 Mentor"),
       
        Person(name:"Teejay Brown", bio:"I am a resource for psychology, biology, and neuroscience. I’m an academic advisor (at Mason and at Northern Virginia Community College), so I advise students of all majors. I help students with college level research paper writing, and I have many connections on campus. I’ve been at Mason for a long time in many different roles: I’ve worked at three different departments, and I have two degrees from Mason. In undergrad, I majored in Psychology and minored in Biology and English. In graduate school I studied Biopsychology (now known as Cognitive and Behavioral Neuroscience). My interests include martial arts (I’ve studied karate, tae kwon do, kickboxing, and boxing), going to the movies, reading, and anything science fiction/fantasy/mythology related. At ODIME I work with first-generation students, including undocumented students.", image:"teejay", role:"Assistant Director/STEP Program Coordinator"),
        Person(name:"Jennifer Crewalk", bio:"I am a graduate from both Rutgers and the University of Pennsylvania. I am currently working on my PhD here at Mason in Educational Psychology, focusing on education equity. In ODIME, I work primarily with Latino/a student groups and Undocumented students. I enjoy telling stories about my large family and life lessons from Peace Corps. I love somatics and can help you relax through yoga, meditation and Jo Kata. I look forward to meeting each of you in person. My door is open for your thoughts, feelings, ideas and concerns.", image:"jennifer", role:"Assistant Director"),
        Person(name:"T. Garey Davis", bio:"I am an alum of Mason and earned my Masters from the University of KwaZulu-Natal in South Africa. I am a resource for international education as well as community engagement and service learning. I have a keen interest in student identity development and increasing cultural competence and awareness. In addition to working at ODIME, I teach courses for three different academic departments: Global and Community Health, New Century College and African and African-American Studies. I’m an avid reader, you can currently find the \"Game of Thrones\" series on my nightstand. If you’re down and need a pick me up, stop by my office for a piece of chocolate and chat.", image:"garey", role:"Assistant Director"),
        Person(name:"Sonia Furuya", bio:"Hola! I’m from Lima, Peru and I’m fluent in Spanish. In my free time I like live music, dancing, and hanging out with my two boys (Sebastian and Francesco). With me what you see is what you get. I’m excited to meet you all!", image:"sonia", role:"Business Manager"),
        
        Person(name:"Ashley Freeman", bio:"I earned my bachelors in Broadcast Journalism from Hofstra University and my Masters of Public Health here at George Mason. I am originally from New York City! During my first year here at Mason, I worked as a graduate assistant for the Wellness, Alcohol, and Violence Education and Services Office organizing programs about sexual health awareness. My second year was dedicated to being a graduate assistant at ODIME helping with Martin Luther King Jr. Week, Black History Month, and Black Graduation 2016. I enjoy writing on my blog, photography, and editing creative videos. I believe that our circumstances don't hinder our future. They are just stepping stones to our success. I can help you discover how to use your personal story as a catalyst to inspire others. I am super excited to spend the summer getting to know more about you all, and I am grateful to be a part of your journey here at Mason.", image:"ashley", role:"Head Program Coordinator"),
        Person(name:"Danielle Coates", bio:"Hi STEP 2016! My name is Danielle Coates, and I am a Senior. I am pursuing a B.F.A in Art and Visual Technology with a concentration in Graphic Design. I currently work in the Office of Diversity, Inclusion and Multicultural Education as the Assistant Coordinator for Graphic Design and Branding; as well as at the Office of Student Scholarship, Creative Activities, & Research as their graphic designer. In addition to designing for ODIME, I also help organize different cultural programs the office sponsors. Since starting at Mason, I’ve been an Art Ambassador, which allowed me to intern with several professors within the School of Art. I’m excited to be with the program again this summer and share the experience with another class. I can't wait to meet everyone!", image:"danielle", role:"Coordinator for Programming"),
        Person(name:"Osaze Shears", bio:"Salvete! My name is Osaze Shears and I am a rising junior in the Honors College here at Mason. I am pursuing an accelerated master's degree in computer engineering with a specialization in humanoid robotics. I was a part of STEP in the summer of 2014, and further assisted with the program in 2015. I have also had the privilege of helping transitioning students not only as a University 100 Peer Advisor, but as the President of F1rst Gen Mason as well. I am super excited to meet you this summer, and I am looking forward to both teaching and learning from this experience!", image:"osaze", role:"Coordinator for Logistics"),
        
        Person(name:"Gia Ha", bio:"Hey, everyone! My name is Gia Ha, and I was a STEP student last summer! I'm a sophomore majoring in Civil, Environmental, and Infrastructure Engineering and my passion is in social justice and gender equality. On campus, I am involved with a student organization called the Society of Hispanic Professional Engineers (SHPE) and I work at ODIME as a STEP advisor and a receptionist. Off campus, I live in Falls Church, VA and I commute everyday. Starting in the fall, I will be a Peer Research Mentor for the Honors College and the secretary of SHPE. I can't wait to meet you all!", image:"gia", role:"Program Assistant"),
        Person(name:"Obum Egolum", bio:"Hey y’all! My name is Obum Egolum, and I am a senior majoring in Information Technology with a concentration in Information Security with dreams of going to Law School and becoming a top lawyer or a CIO. I am heavily involved at Mason, having served as a Senator in Student Government and also in the Black Community having been Vice President and President of the African Student Association, a founding member of the Black Leadership Roundtable, and coming into this year as a Senator for the National Society of Black Engineers. I am excited to meet you guys and assist with your matriculation into #MasonNation!", image:"obum", role:"Program Assistant"),
        Person(name:"Jimez Ashby", bio:"I am a rising senior pursuing a Bachelor of Science in Community Health with a focus on Health Education from St. Thomas, US Virgin Islands. I have been highly involved on campus, with a record including serving as President of the Caribbean Student Association, Vice President of Gent Men, Founder of the Black Male Recognition Project, Founding Member of F1RST Gen Mason, a Mason Ambassador, Team SI Staff Member, a Chair of the Black Excellence Gala Committee, and the new Internal President of The Association of Collegiate Black Men. I have a strong passion for community service which is demonstrated through my daily work and continued involvement with Rotary International, Habitat for Humanity, and Salvation Army. Upon completion of my Bachelor’s Degree, I plan to obtain a Master’s in Public Health before heading to Medical School with the goal of becoming a Physician and Health Educator. Life Motto: \"Success is not a goal, Success is a lifestyle\"", image:"jimez", role:"Program Assistant")
        
    ]
    
    var countReloads:Int = 0


    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 123.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.people.count
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PersonCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PeopleTableViewCell
        
        // Configure the cell...
        let person = people[indexPath.row]
        cell.nameLabel.text = person.name
        cell.profileImge.image = UIImage(named:person.image)
        cell.occupationLabel.text = person.role
        
        // Circular image
        cell.profileImge.layer.cornerRadius = cell.profileImge.frame.size.width / 2
        cell.profileImge.clipsToBounds = true
        

        //cell.setNeedsLayout()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detailedPerson" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let destinationController = segue.destinationViewController as! DetailPersonTableViewController
                destinationController.person = self.people[row]
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }
    @IBAction func unwindToPeopleScreen(segue:UIStoryboardSegue) {
        
    }
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row==self.tableView.indexPathsForVisibleRows?.first?.row ){
            // Launch walkthrough screens
            let defaults = NSUserDefaults.standardUserDefaults()
            let hasViewedWalkthrough = defaults.boolForKey("hasViewedPeoplePopTip")
            
            if hasViewedWalkthrough == false {
                defaults.setBool(true, forKey: "hasViewedPeoplePopTip")
                showPopTip(cell,message: "Tap people to learn more about them!")
            }
        }

        if (indexPath.row==self.tableView.indexPathsForVisibleRows?.last?.row && countReloads<2){
            countReloads += 1
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    func showPopTip(sender: AnyObject, message: String) {
        let popTip = SwiftPopTipView(title: "ProTip!", message: message)
        popTip.popColor = UIColor(red: 0/255, green: 102/255, blue: 51/255, alpha: 1)
        popTip.titleColor = UIColor.whiteColor()
        popTip.textColor = UIColor.whiteColor()
        if sender.dynamicType === UIBarButtonItem.self {
            popTip.presentAnimatedPointingAtBarButtonItem(sender as! UIBarButtonItem, autodismissAtTime: 10)
        } else {
            popTip.presentAnimatedPointingAtView(sender as! UIView, inView: self.view, autodismissAtTime: 10)
        }
    }
    

}
