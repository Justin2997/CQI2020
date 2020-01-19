import React from 'react';
import ReactDOM from 'react-dom';
import LoanApplication from './LoanApplication';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<LoanApplication />, div);
  ReactDOM.unmountComponentAtNode(div);
});
