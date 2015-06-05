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
        Person(name:"Felicia Baez", bio:"Hey STEP family! My name is Felicia Baez and I am a junior at GMU from Richmond, Virginia. My major is Integrative Studies with a concentration in International Studies and I have a minor in Women and Gender Studies. On campus I am involved in a student organization called Chase Dreams Not Boys, I am a Peer Health Educator with the Wellness, Alcohol, Violence, Education, and Services office, and starting in the fall semester I will be a Resident Advisor. One interesting fact about me is that I have studied abroad in Granada, Spain! I am so excited to meet you all and I know we are going to have a great summer!", image:"felicia", role:"STEP 2015 Mentor"),
        Person(name:"Ebadullah Ebadi", bio:"Hi there! My name is Ebadullah Ebadi and I am a senior at George Mason University majoring in Government & International Politics with a minor in Communication! I was a part of STEP 2011 cohort! Throughout my time here at Mason, I have been involved with the Afghan Student Union, the Muslim Student Association, Pi Sigma Alpha Political Science Honor Society, and various other activities! I am the Outreach Coordinator for ODIME and a Head Resident Advisor for Housing & Residence Life. Some of my hobbies include watching movies, playing sports, spending time with loved ones, and playing music with my band, Leftist! I hope you all enjoy STEP and the memories you will make with one another during this time and your next few years here. I am excited to be working with you all!", image:"ebi", role:"STEP 2015 Mentor"),
        Person(name:"Vivi Luong", bio:"Hi all! My name is Vivi Luong! I’m a senior at GMU, majoring in Communication and minoring in Sports Communication. I am an Events Manager for GMU’s Student Involvement office, a Resident Advisor and a Peer Advisor! I was born in Ho Chi Minh City, Vietnam and grew up in Los Angeles, California! I LOVE TRAVELING! I would love to visit as many countries and it is my dream to visit some of the world’s best beaches. I like to workout during my free time, especially when I get to go to a fitness class and has lots of DANCING! However during MOST of my free time I binge watch Netflix and YouTube videos! I’m looking forward to spending this summer with the STEP program because it was on my GMU Bucket List to become a mentor, so I am VERY EXCITED!!! It will be plenty of fun getting to know you all and I cannot wait!", image:"vivi", role:"STEP 2015 Mentor"),
        Person(name:"Rodrigo Velasquez", bio:"Hello STEP 2015 scholars! My name is Rodrigo Velasquez and I'm really excited to be a STEP mentor this summer! I'm a rising Senior majoring in Communication with a concentration in Public Relations and minoring in Women and Gender Studies. This fall I'll also be starting an Accelerated Masters program in Women and Gender Studies with the hope of focusing my research on undocumented women. I was born in Cochabamba, Bolivia, love short walks to the fridge, and occasionally I can be found at a protest somewhere in the area. In the past, I've served as a Leadership Consultant, Resident Advisor, Teaching Assistant for LGBTQ Studies, Delegate for the Global Engagement Summit, and a few other things on and off campus. Next year I'm excited to be the President of Mason DREAMers and continue my advocacy as an organizer with GMU Student Power, the Virginia Student Power Network, and Students Against Israeli Apartheid! I was also in STEP during the summer of 2012! I’m excited to go through this experience with you!", image:"rodrigo", role:"STEP 2015 Mentor"),
        Person(name:"Teejay Brown", bio:"I am a resource for psychology, biology, and neuroscience. I’m an academic advisor (at Mason and at Northern Virginia Community College), so I advise students of all majors. I help students with college level research paper writing, and I have many connections on campus. I’ve been at Mason for a long time in many different roles: I’ve worked at three different departments, and I have two degrees from Mason. In undergrad, I majored in Psychology and minored in Biology and English. In grad. school I studied Biopsychology (now known as Cognitive and Behavioral Neuroscience). My interests include martial arts (I’ve studied karate, tae kwon do, kickboxing, and boxing), going to the movies, reading, and anything science fiction/fantasy/mythology related.", image:"teejay", role:"Assistant Director/STEP Coordinator"),
        Person(name:"Jennifer Crewalk", bio:"I am a graduate from both Rutgers and the University of Pennsylvania. I am currently working on my PhD here at Mason in Educational Psychology, focusing on education equity. In ODIME, I work primarily with Latino/a student groups and Undocumented students. I enjoy telling stories about my large family and life lessons from Peace Corps. I love somatics and can help you relax through yoga, meditation and Jo Kata. I look forward to meeting each of you in person. My door is open for your thoughts, feelings, ideas and concerns.", image:"jennifer", role:"Assistant Director"),
        Person(name:"T. Garey Davis", bio:"I am an alum of Mason and earned my Masters from the University of KwaZulu-Natal in South Africa. I am a resource for international education as well as community engagement and service learning. I have a keen interest in student identity development and increasing cultural competence and awareness. In addition to working at ODIME, I teach courses for three different academic departments: Global and Community Health, New Century College and African and African-American Studies. I’m an avid reader, you can currently find the Game of Thrones series on my nightstand. If you’re down and need a pick me up, stop by my office for a piece of chocolate and chat.", image:"garey", role:"Assistant Director"),
        Person(name:"Olivia Cheetham", bio:"I earned my master's in Spanish and Multicultural Education and my undergraduate degree is in English and Spanish literature. I am originally from Los Angeles; however, I've spent more than half of my life in Virginia. During my educational career at Mason I worked as a graduate assistant for the Office of Housing and Residence Life, so I am a resource for housing related matters. I love everything about music, and I love couponing and bargain hunting. Also, I enjoy movies, particularly sci-fi and comedies. I am super excited to meet you all, and I am grateful to be a part of your journey here at Mason.", image:"olivia", role:"Program Coordinator"),
        Person(name:"Dr. Rebecca Walter", bio:"I am a resource for public speaking/communication studies, critical media/ media studies, animals/animal shelter work, vegetarianism/vegan, identity development, power, privilege, and white people as social justice activists. My interest include critical race theory, queer and feminist theories, intersectionality (of identities). I also like exercising and walking and bunnies!", image:"rebecca", role:"Associate Director"),
        Person(name:"Dr. Shaoxian Yu", bio:"I serve as one of the resources for Asian Pacific American (APA) and Native American student affairs in ODIME and serve as Faculty Advisor for several APA student organizations and Native American and Indigenous Alliance (NAIA). I am also a resource person for International students. My Ph.D is in College Student Personnel, and my M.A. is in Interpersonal Communication. Chinese is my native language, and I speak Mandarin. My interests include conversations about the meaning of life, basketball, volleyball, ping pong, skating, and fishing.", image:"shaoxian", role:"Associate Director"),
        Person(name:"Jumana Kamal", bio:"Salaam! I am the Office and Program Manager here at ODIME. I speak Arabic fluently and advise five student organizations that include MSA, Access Islam, Project Nur, United Muslim Relief and UNICEF. Although I graduated from high school in Houston, I went back to Jordan for a few years where I received my BA. Upon my return to the US in 2007, I spent some time with a local non- profit that advocates for social justice and mutual understanding through enhancing the understanding of Islam and encouraging dialogue and empowering American Muslims. I just completed my MA degree in Middle East and Islamic Studies here at Mason, and have special interests in photography, interior design, and graphic design. I look forward to meeting you all!", image:"jumana", role:"Office and Program Manager"),
        Person(name:"Sonia Furuya", bio:"Hola! I’m from Lima, Peru and I’m fluent in Spanish. In my free time I like live music, dancing, and hanging out with my two boys (Sebastian and Francesco). With me what you see is what you get. I’m excited to meet you all!", image:"sonia", role:"Business Manager"),
        Person(name:"Danielle Coates", bio:"Hi STEP 2015! My name is Danielle Coates and I am a Junior. I am majoring in Art and Visual Technology with a concentration in Drawing and Graphic Design. I currently work in the Office of Diversity, Inclusion and Multicultural Education as the Assistant Coordinator for Graphic Design and Branding. This summer I am the Assistant Coordinator of Programming for STEP, so I will be planning the fun weekend activities! I will also be a resource for the summer's Art History class. I can't wait to meet everyone!", image:"danielle", role:"Assistant Coordinator for Programming"),
        Person(name:"Shanice Ford", bio:"My name is Shanice Ford, I am a Junior here at Mason and a first generation student. I am a Communication major with a minor in Sports Communication. One day I hope to be a sports anchor! I currently work on campus as a Resident Advisor as well as a Desk Assistant/Logistics Coordinator with STEP.", image:"shanice", role:"Assistant Coordinator for Logistics"),
        Person(name:"Osaze Shears", bio:"Salve! I am a sophomore computer science and engineering major here at Mason. I am from the Hampton Roads area and enjoy mobile application development and graphic design. I am the Technology and Equipment coordinator at ODIME and have an extensive background in mathematics coursework. I love to play soccer and enjoy sharing good laughs with others!", image:"osaze", role:"Intern for Logistics"),
        Person(name:"Alexandro Villarroel", bio:"¡Hola mis futuro amigos! My name is Alexandro C. Villarroel, I’m a rising sophomore. I am a Criminology Law & Society major with minors in Intelligence Analysis and IT. I was in the STEP class of 2014.This summer I will be one of the interns for your class. I love cooking, exercising, listening to music (especially The Weeknd), & longboarding. For those taking public speaking and the art history class, come to me for any questions, I’d be happy to help. ¡Buena Suerte!", image:"alex", role:"Intern for Programming"),
        Person(name:"Kristi Mokube", bio:"Hi! My name is Kristi Mokube and I am a rising senior at GMU! I am an Integrative Studies major and I play on the Women’s basketball team as a forward! If you want to get ready for Dr. Yu’s basketball tournament, let me know! Can’t wait to meet you all!", image:"kristi", role:"Intern for Activities")
        
    ]
    
    var countReloads:Int = 0


    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Side Menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
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
            if let row = tableView.indexPathForSelectedRow()?.row {
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
        if (indexPath.row==self.tableView.indexPathsForVisibleRows()?.last?.row && countReloads<2){
            countReloads++
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    

}
