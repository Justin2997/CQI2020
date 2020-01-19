import React from 'react';
import ReactDOM from 'react-dom';
import LoanApplicationHistory from './LoanApplicationHistory';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<LoanApplicationHistory />, div);
  ReactDOM.unmountComponentAtNode(div);
});
