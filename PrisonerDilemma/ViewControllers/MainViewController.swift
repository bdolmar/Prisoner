//
//  ViewController.swift
//  PrisonerDilemma
//
//  Created by Ben Dolmar on 12/25/15.
//  Copyright © 2015 Ben Dolmar. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet var scoreboardView: ScoreboardView!
    @IBOutlet var leaderboardView: NSTableView!
    
    private var runner: StatisticsRunner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = Configuration()
        let statisticsRunner = configuration.container.resolve(StatisticsRunner.self)!
        
        // Set the delegate
        statisticsRunner.delegate = self
        self.runner = statisticsRunner
        statisticsRunner.startListening()

        let player1 = Prisoner(username: "jklun", discipline: .JVM, sentence: 14)
        let player2 = Prisoner(username: "cdavis", discipline: .Mobile, sentence: 4)

        let round = CompetitionRound(player1: player1, player2: player2, roundNumber: 13)
        self.scoreboardView.updateWithRound(round)
        
        let leaderboardCell = NSNib(nibNamed: "LeaderboardCell", bundle: NSBundle.mainBundle())
        self.leaderboardView.registerNib(leaderboardCell, forIdentifier: "LeaderboardCell")
        self.leaderboardView.reloadData()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension MainViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 5
    }

}

extension MainViewController: NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let result = tableView.makeViewWithIdentifier("LeaderboardCell", owner: self);

        return result
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 119.0
    }
}

extension MainViewController: StatisticsConsumer {
    func useCompetitionStandings(standings: CompetitionStandings) {
        // TODO: Add your usage logic here, bdolmar
        self.scoreboardView.updateWithRound(standings.currentRound)
    }
}
