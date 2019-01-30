//
//  ViewController.swift
//  Calendar
//
//  Created by 逸唐陳 on 2018/8/21.
//  Copyright © 2018年 逸唐陳. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let monthView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "January 2018"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let previousButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("<", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(">", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let weekView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let stackView: UIStackView = {
        let sunDay: UILabel = {
            let label = UILabel()
            label.text = "日"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let monDay: UILabel = {
            let label = UILabel()
            label.text = "一"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let tuesday: UILabel = {
            let label = UILabel()
            label.text = "二"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let wednesday: UILabel = {
            let label = UILabel()
            label.text = "三"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let thursday : UILabel = {
            let label = UILabel()
            label.text = "四"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let friday: UILabel = {
            let label = UILabel()
            label.text = "五"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let saturday: UILabel = {
            let label = UILabel()
            label.text = "六"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let view = UIStackView(arrangedSubviews: [sunDay,monDay,tuesday,wednesday,thursday,friday,saturday])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.frame.width / 7, height: 40)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.sectionInset.bottom = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var week = ["日","一","二","三","四","五","六"]
    let event = [["1","2","3"],
                 ["1","2","3"],
                 ["1","2","3"],
                 ["1","2"],
                 [],
                 ["1","2","3"],
                 [],
                 [],
                 [],
                 [],
                 [],
                 ["1","2","3"],
                 [],
                 [],
                 ["1","2","3"],
                 ["1","2","3"],
                 ["1","2","3"],
                 ["1","2","3"],
                 ["1","2","3"],
                 ["1","2","3"],
                 ["1","2"],
                 [],
                 ["1","2","3"],
                 [],
                 [],
                 [],
                 [],
                 [],
                 ["1","2","3"],
                 [],
                 ["1","2","3"]]
    var numberOfDaysInThisMonth: Int {
        let dateComponents = DateComponents(year: currentYear ,
                                            month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month,
                                           for: date)
        return range?.count ?? 0
    }
    var whatDayIsIt: Int {
        let dateComponents = DateComponents(year: currentYear ,
                                            month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    
    var howManyItemsShouldIAdd:Int{
        return whatDayIsIt - 1
    }
    
    var selectedEvent: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .lightGray
        view.backgroundColor = .white
        prepareMonthView()
        prepareWeekView()
        prepareCollectionView()
        setUp()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendarCollectionView.collectionViewLayout.invalidateLayout()
        calendarCollectionView.reloadData()
    }
    
    private func prepareMonthView() {
        view.addSubview(monthView)
        monthView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        monthView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        monthView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        monthView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        monthView.addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: monthView.centerYAnchor).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: monthView.centerXAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        monthView.addSubview(previousButton)
        previousButton.leadingAnchor.constraint(equalTo: monthView.leadingAnchor, constant: 15).isActive = true
        previousButton.centerYAnchor.constraint(equalTo: monthView.centerYAnchor).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        previousButton.addTarget(self, action: #selector(previousHandler), for: .touchUpInside)
        monthView.addSubview(nextButton)
        nextButton.trailingAnchor.constraint(equalTo: monthView.trailingAnchor, constant: -15).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: monthView.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        nextButton.addTarget(self, action: #selector(nextHandler), for: .touchUpInside)
    }
    
    private func prepareWeekView() {
        view.addSubview(weekView)
        weekView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive = true
        weekView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weekView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weekView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        weekView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: weekView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: weekView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: weekView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: weekView.bottomAnchor).isActive = true
    }
    
    private func prepareCollectionView() {
        view.addSubview(calendarCollectionView)
        calendarCollectionView.topAnchor.constraint(equalTo: weekView.bottomAnchor).isActive = true
        calendarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        calendarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        calendarCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        calendarCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        calendarCollectionView.register(EventCell.self, forCellWithReuseIdentifier: "eventCell")
    }
    
    func setUp(){
        dateLabel.text = months[currentMonth - 1] + " \(currentYear)"
        calendarCollectionView.reloadData()
    }
    
    @objc func nextHandler() {
        currentMonth += 1
        if currentMonth == 13{
            currentMonth = 1
            currentYear += 1
        }
        setUp()
    }
    
    @objc func previousHandler() {
        currentMonth -= 1
        if currentMonth == 0{
            currentMonth = 12
            currentYear -= 1
        }
        setUp()
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return numberOfDaysInThisMonth + howManyItemsShouldIAdd
        }else {
            if let count = selectedEvent?.count {
                return count
            }else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
            cell.backgroundColor = .gray
            if indexPath.row < howManyItemsShouldIAdd {
                cell.dateLabel.text = ""
            }else{
                cell.dateLabel.text = "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
//                cell.event = event[indexPath.row - howManyItemsShouldIAdd]
            }
            return cell
        }else {
            let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            cell.eventTitle.text = selectedEvent?[indexPath.item]
            cell.backgroundColor = .black
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width / 7 - 1, height: 60)
        }else {
            return CGSize(width: view.frame.width, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let day = indexPath.row + 1 - howManyItemsShouldIAdd
            let month = currentMonth
            let year = currentYear
            let date = "\(year)-\(month)-\(day)"
            if day >= 1 {
                let today = "星期 \(week[getDayOfWeek(date)! - 1])"
                print(today)
            }
            let selectedDate = indexPath.row - howManyItemsShouldIAdd
            if selectedDate >= 0 {
                selectedEvent = event[selectedDate]
                if selectedEvent!.count > 0 {
//                    print(selectedEvent)
                    calendarCollectionView.reloadSections(IndexSet(integer: 1))
                    calendarCollectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
                }else {
                    calendarCollectionView.reloadSections(IndexSet(integer: 1))
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return CGFloat(1)
        }else {
            return CGFloat(1)
        }
    }
    
}

