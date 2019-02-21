Feature: Stanford School of Engineering Menus
  In order to ensure that the SoE menus are configured correctly
  I want to check for the correct menu items

  @live
  Scenario: Verify that we have the correct main navigation items
    Given I am on the homepage
    Then I should see "Admission & Aid" in the "Main Navigation" region
    Then I should see "Students & Academics" in the "Main Navigation" region
    Then I should see "Faculty & Research" in the "Main Navigation" region
    Then I should see "Get Involved" in the "Main Navigation" region
    And I should see "About" in the "Main Navigation" region
    
  @live
  Scenario: Verify that we have the correct Admission & Aid navigation items
    Given I am on the homepage
    When I click "Admission & Aid"
    Then I should be on "admission-aid"

    When I click "Graduate Admission"
    Then I should be on "admission-aid/graduate-admission"

    When I click "Coterm"
    Then I should be on "admission-aid/coterminal-study-engineering"

    When I click "Financial Aid"
    Then I should be on "admission-aid/financial-aid"

  @live
  Scenario: Verify that we have the correct Students & Academics navigation items
    Given I am on the homepage
    When I click "Students & Academics"
    Then I should be on "students-and-academics"

    When I click "Academics"
    Then I should be on "students-academics/academics"
    When I click "Undergraduate Degree Programs"
    Then I should be on "students-academics/academics/undergraduate-degree-programs"
    When I click "Graduate Degree Programs"
    Then I should be on "students-academics/academics/graduate-degree-programs"
    When I click "Online Learning"
    Then I should be on "students-academics/academics/online-learning"
    When I click "Student Awards"
    Then I should be on "students-academics/academics/frederick-emmons-terman-engineering-scholastic-award"

    When I click "Support and Resources"
    Then I should be on "students-academics/support-and-resources"
    When I click "Undergraduate Resources"
    Then I should be on "students-academics/support-and-resources/undergraduate-resources"
    When I click "Graduate Resources"
    Then I should be on "students-academics/support-and-resources/graduate-resources"
    When I click "Academic Advising"
    Then I should be on "students-academics/support-and-resources/academic-advising"
    When I click "Tutoring"
    Then I should be on "students-academics/support-and-resources/tutoring"
    When I click "Career Resources"
    Then I should be on "students-academics/support-and-resources/career-resources"
    When I click "Jobs and Internships"
    Then I should be on "students-academics/support-and-resources/jobs-and-internships"
    When I click "International Students"
    Then I should be on "students-academics/support-and-resources/international-students"
    When I click "Student Group Funding"
    Then I should be on "students-academics/support-and-resources/student-group-funding"
    When I click "Student Organizations"
    Then I should be on "students-academics/support-and-resources/student-organizations"
    When I click "Terman Engineering Library"
    Then I should be on "students-academics/support-and-resources/terman-engineering-library"

    When I click "Global Engineering Programs"
    Then I should be on "students-academics/global-engineering-programs"
    When I click "Explore GEP programs"
    Then I should be on "students-academics/global-engineering-programs/explore-gep-programs"
    When I click "Faculty-led programs"
    Then I should be on "students-academics/global-engineering-programs/study-tours"
    When I click "Service-learning Opportunities"
    Then I should be on "students-academics/global-engineering-programs/service-learning"
    When I click "International Internships"
    Then I should be on "students-academics/global-engineering-programs/internships"
    When I click "Faculty Information"
    Then I should be on "students-academics/global-engineering-programs/faculty-information"
    When I click "Travel Information"
    Then I should be on "students-academics/global-engineering-programs/travel-information"
    When I click "Corporate Partners"
    Then I should be on "students-academics/global-engineering-programs/corporate-partners"
    Then I should see the text "About" in the "First sidebar" region
    When I click "Explore GEP programs"
    Then I should be on "students-academics/global-engineering-programs/explore-gep-programs"

    When I click "Engineering Diversity Programs"
    Then I should be on "students-academics/engineering-diversity-programs"
    When I click "About the program"
    Then I should be on "students-academics/engineering-diversity-programs/about-engineering-diversity-program"
    When I click "Stanford Summer Engineering Academy"
    Then I should be on "students-academics/engineering-diversity-programs/stanford-summer-engineering-academy-ssea"
    When I click "Pre College Programs"
    Then I should be on "students-academics/engineering-diversity-programs/pre-college-programs-engineering-diversity"
    When I click "Additional Calculus for Engineers"
    Then I should be on "students-academics/engineering-diversity-programs/additional-calculus-engineers-ace"
    When I click "Graduate Professional and Peer Advising"
    Then I should be on "students-academics/engineering-diversity-programs/graduate-professional-and-peer-advising-gp2a"
    When I click "Summer Undergraduate Research Fellowship"
    Then I should be on "students-academics/engineering-diversity-programs/summer-undergraduate-research-fellowship-surf"
    When I click "Summer Session Grants"
    Then I should be on "students-academics/engineering-diversity-programs/summer-session-grants-ssg"
    When I click "Financial Aid"
    Then I should be on "students-academics/engineering-diversity-programs/financial-aid-internships-and-scholarships"
    When I click "Engineering Opportunity Job Fair"
    Then I should be on "students-academics/engineering-diversity-programs/career-fair-stanford-engineering-opportunity-job"
    When I click "Corporate Sponsors"
    Then I should be on "students-academics/engineering-diversity-programs/corporate-sponsors"
    When I click "Engineering Diversity Student Societies"
    Then I should be on "students-academics/engineering-diversity-programs/engineering-diversity-student-societies"
    When I click "Graduate Advising and Guidance"
    Then I should be on "students-academics/engineering-diversity-programs/graduate-advising-and-guidance"
    When I click "Graduate Diversity Recruitment"
    Then I should be on "students-academics/engineering-diversity-programs/graduate-diversity-recruitment"
    When I click "Graduate Fellowships and Financial Aid"
    Then I should be on "students-academics/engineering-diversity-programs/graduate-fellowships-and-financial-aid"
    When I click "Graduate Pathways to STEM"
    Then I should be on "students-academics/engineering-diversity-programs/graduate-pathways-stem"

    When I click "Technical Communication Program"
    Then I should be on "students-academics/technical-communication-program"
    When I click "Consulting Request Form"
    Then I should be on "students-academics/support-and-resources/technical-communication-program/consulting-request-form"
    When I click "Frequently Asked Questions"
    Then I should be on "students-academics/technical-communication-program/tcp-frequently-asked-questions"

    When I click "The Student Experience"
    Then I should be on "students-academics/student-experience"

  @live
  Scenario: Verify that we have the correct Faculty & Research navigation items
    Given I am on the homepage
    When I click "Faculty & Research"
    Then I should be on "faculty-research"

    When I click "Faculty"
    Then I should be on "people/faculty/grid"
    When I click "Emeritus Faculty"
    Then I should be on "people/emeritus/grid"
    When I click "In Memoriam"
    Then I should be on "people/in-memoriam/grid"

    When I click "Events"
    Then I should be on "events/upcoming-events"

    When I click "Departments"
    Then I should be on "faculty-research/departments"
    When I click "Aeronautics & Astronautics"
    Then I should be on "faculty-research/departments/aeronautics-astronautics"
    When I click "Bioengineering"
    Then I should be on "faculty-research/departments/bioengineering"
    When I click "Chemical Engineering"
    Then I should be on "faculty-research/departments/chemical-engineering"
    When I click "Civil & Environmental Engineering"
    Then I should be on "faculty-research/departments/civil-environmental-engineering"
    When I click "Computer Science"
    Then I should be on "faculty-research/departments/computer-science"
    When I click "Electrical Engineering"
    Then I should be on "faculty-research/departments/electrical-engineering"
    When I click "Management Science & Engineering"
    Then I should be on "faculty-research/departments/management-science-engineering"
    When I click "Materials Science & Engineering"
    Then I should be on "faculty-research/departments/materials-science-engineering"
    When I click "Mechanical Engineering"
    Then I should be on "faculty-research/departments/mechanical-engineering"

    When I click "Institutes, Labs and Centers"
    Then I should be on "faculty-research/institutes-labs-and-centers"

    When I click "Faculty Awards"
    Then I should be on "faculty-research/faculty-awards"
    When I click "2015-2016"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2015-2016"
    When I click "2014-2015"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2014-2015"
    When I click "2012-2013"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2012-2013"
    When I click "2011-2012"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2011-2012"
    When I click "2010-2011"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2010-2011"
    When I click "2009-2010"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2009-2010"
    When I click "2008-2009"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2008-2009"
    When I click "2007-2008"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2007-2008"
    When I click "2006-2007"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2006-2007"
    When I click "2005-2006"
    Then I should be on "faculty-research/faculty-awards/faculty-awards-2005-2006"

  @live
  Scenario: Verify that we have the correct Get Involved navigation items
    Given I am on the homepage
    When I click "Get Involved"
    Then I should be on "get-involved"

    When I click "Give"
    Then I should be on "get-involved/give"
    When I click "Endowed Department Chairs"
    Then I should be on "get-involved/give/endowed-department-chairs"
    When I click "Endowed Professorships"
    Then I should be on "get-involved/give/endowed-professorships"
    When I click "Endowed Faculty Scholars"
    Then I should be on "get-involved/give/endowed-faculty-scholars"
    When I click "Endowed Graduate Fellowships"
    Then I should be on "get-involved/give/endowed-graduate-fellowships"
    When I click "Coterm Opportunity Fellowship Program"
    Then I should be on "get-involved/give/coterm-opportunity-fellowship-program"
    When I click "Annual Giving"
    Then I should be on "get-involved/give/annual-giving"
    When I click "How to Make Your Gift"
    Then I should be on "get-involved/give/how-make-your-gift"

    When I click "Collaborations"
    Then I should be on "get-involved/collaborations"
    When I click "Join an Affiliate Program"
    Then I should be on "get-involved/collaborations/join-affiliate-program"
    When I click "Affiliate Programs"
    Then I should be on "get-involved/collaborations/join-affiliate-program/affiliate-programs"
    When I click "Industry Collaborations"
    Then I should be on "get-involved/collaborations/industry-collaborations"
    When I click "Recruiting"
    Then I should be on "get-involved/collaborations/recruit-students-and-alumni"

    When I click "Alumni"
    Then I should be on "get-involved/alumni"
    When I click "Career Resources"
    Then I should be on "get-involved/alumni/career-resources"
    When I click "Alumni Events"
    Then I should be on "get-involved/alumni/alumni-events"
    When I click "Volunteer"
    Then I should be on "get-involved/alumni/volunteer"

    When I click "Letters from Department Chairs"
    Then I should be on "get-involved/letters-department-chairs"

  @live
  Scenario: Verify that we have the correct About navigation items
    Given I am on the homepage
    When I click "About"
    Then I should be on "about"
    When I click "Dean"
    Then I should be on "about/dean"
    When I click "Dean’s Office"
    Then I should be on "about/dean-s-office"
    When I click "Heroes"
    Then I should be on "about/heroes"
    When I click "School News"
    Then I should be on "news/school-news"
    When I click "History"
    Then I should be on "about/history"
    When I click "Visit"
    Then I should be on "about/visit"
    When I click "SoE-Future"
    Then I should be on "about/soe-future"
