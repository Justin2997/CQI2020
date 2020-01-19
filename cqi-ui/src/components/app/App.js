import React from 'react';
import { BrowserRouter as Router, Switch, Route, Link } from 'react-router-dom';

import logo from '../../assets/images/logo.png';
import './App.css';
import LoanApplication from '../LoanApplication/LoanApplication';
import LoanApplicationHistory from '../LoanApplicationHistory/LoanApplicationHistory';

function App() {
  return (
    <Router>
      <div>
        <h2>Bienvenue chez Hypothèque Intelligente</h2>
        <nav className="navbar navbar-expand-lg navbar-light bg-light">
          <ul className="navbar-nav mr-auto">
            <li><Link to={'/loanapplication'} className="nav-link"> Demande </Link></li>
            <li><Link to={'/loanhistory'} className="nav-link"> Historique des demandes </Link></li>
          </ul>
        </nav>
        <hr />
        <Switch>
          <Route exact path='/loanapplication' component={LoanApplication} />
          <Route path='/loanhistory' component={LoanApplicationHistory} />
        </Switch>
      </div>
    </Router>
  );
}

export default App;
