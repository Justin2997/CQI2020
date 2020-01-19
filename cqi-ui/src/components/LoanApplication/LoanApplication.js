import React, { useState } from 'react';

import MaterialTable from "material-table";
import TextField from '@material-ui/core/TextField';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import Favorite from '@material-ui/icons/Favorite';
import FavoriteBorder from '@material-ui/icons/FavoriteBorder';
import Checkbox from '@material-ui/core/Checkbox';
import Icon from '@material-ui/core/Icon';
import SaveIcon from '@material-ui/icons/Save';

import { makeStyles } from '@material-ui/core/styles';

import logo from '../../assets/images/logo.png';
import './LoanApplication.css';
import { Button } from '@material-ui/core';

const useStyles = makeStyles(theme => ({
  container: {
    display: 'flex',
    flexWrap: 'wrap',
  },
  textField: {
    marginLeft: theme.spacing(1),
    marginRight: theme.spacing(1),
    width: 200,
  },
}));

function LoanApplication() {
  const classes = useStyles();

  const [loanData, setLoanData] = React.useState({
    age: 18,
    current_residence_years: 1,
    is_married: false,
    number_of_dependants: 1,
    graduated: false,
    self_employed: false,
    years_of_job_stability: 2,
    yearly_salary: 25000,
    credit_rating: '',
    loan_term_in_years: 10,
    loan_amount: 200000,
    property_total_cost: 215000,
    area_classification: 'CLASS_A',
    co_applicant_age: 25,
    co_applicant_years_of_job_stability: 5,
    co_applicant_yearly_salary: 50000,
    co_applicant_credit_rating: '',
  })

  const handleChange = name => event => {
    console.log('NAME: ', name)
    console.log('EVENT: ', event)
    setLoanData({ ...loanData, [name]: event.target.value })
  }

  const endpoint = 'http://localhost:8000/profile/create'

  function createLoanApplication() {
    console.warn('Creating loan application')
    console.log('BODY: ', JSON.stringify(loanData))
    fetch(`${endpoint}`,
      {
        method: 'POST',
        body: JSON.stringify(loanData),
        headers: {
          'Content-Type': 'application/json'
        }
      }).then((response) => {
        if (response.ok) {
          if (response.data.approved)
            alert('Demande approuvée.')
          else
            alert('Demande refusée.')
        } else {
          alert('There was an error while trying to process loan application.')
        }
      }).catch((error) => {
        alert('Connexion impossible, veuillez réessayer.')
        console.error('error in connection: ', error);
      });
  }

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h2>
          Demande de prêt
        </h2>

        <h4 style={{ alignContent: 'left' }}> Données personnelles </h4>
        <form className={classes.container} noValidate autoComplete="off">
          <div>
            <TextField
              id="outlined-number"
              value={loanData.age}
              onChange={handleChange('age')}
              label="Âge"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField
              id="outlined-number"
              value={loanData.current_residence_years}
              onChange={handleChange('current_residence_years')}
              label="Années à résidence actuelle"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <FormControlLabel
              style={{ verticalAlign: 'baseline' }}
              control={
                <Checkbox value="loanData.is_married" />
              }
              onChange={handleChange('is_married')}
              label="Marié"
            />
            <TextField
              id="outlined-number"
              value={loanData.number_of_dependants}
              onChange={handleChange('number_of_dependants')}
              label="Nombre de personnes à charge"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
          </div>
        </form>

        <h4 style={{ alignContent: 'left' }}> Éducation et emploi </h4>
        <form className={classes.container} noValidate autoComplete="off">
          <div>
            <FormControlLabel
              style={{ verticalAlign: 'baseline' }}
              control={
                <Checkbox value="loanData.graduated" />
              }
              onChange={handleChange('graduated')}
              label="Gradué"
            />
            <FormControlLabel
              style={{ verticalAlign: 'baseline' }}
              control={
                <Checkbox value="loanData.self_employed" />
              }
              onChange={handleChange('self_employed')}
              label="Travailleur autonome"
            />
            <TextField
              id="outlined-number"
              value={loanData.years_of_job_stability}
              onChange={handleChange('years_of_job_stability')}
              label="Années à l'emploi actuel"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField
              id="outlined-number"
              value={loanData.yearly_salary}
              onChange={handleChange('yearly_salary')}
              label="Salaire annuel"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField // TODO change to only allow the possible values
              id="outlined-number"
              value={loanData.credit_rating}
              onChange={handleChange('credit_rating')}
              label="Cote de crédit"
              type="text"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />

          </div>
        </form>

        <h4 style={{ alignContent: 'left' }}> Informations du prêt </h4>
        <form className={classes.container} noValidate autoComplete="off">
          <div>
            <TextField
              id="outlined-number"
              value={loanData.loan_term_in_years}
              onChange={handleChange('loan_term_in_years')}
              label="Durée du prêt"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField
              id="outlined-number"
              value={loanData.loan_amount}
              onChange={handleChange('loan_amount')}
              label="Montant du prêt"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField
              id="outlined-number"
              value={loanData.property_total_cost}
              onChange={handleChange('property_total_cost')}
              label="Valeur de la propriété"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField
              id="outlined-number"
              value={loanData.area_classification}
              onChange={handleChange('area_classification')}
              label="Classification du quartier"
              type="text"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
          </div>
        </form>

        <h4 style={{ alignContent: 'left' }}> Co-demandant </h4>
        <form className={classes.container} noValidate autoComplete="off">

          <div>
            <TextField
              id="outlined-number"
              value={loanData.co_applicant_age}
              onChange={handleChange('co_applicant_age')}
              label="Âge"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField
              id="outlined-number"
              value={loanData.co_applicant_years_of_job_stability}
              onChange={handleChange('co_applicant_years_of_job_stability')}
              label="Années à l'emploi actuel"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField
              id="outlined-number"
              value={loanData.co_applicant_yearly_salary}
              onChange={handleChange('co_applicant_yearly_salary')}
              label="Salaire annuel"
              type="number"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
            <TextField // TODO change to only allow the possible values
              id="outlined-number"
              value={loanData.co_applicant_credit_rating}
              onChange={handleChange('co_applicant_credit_rating')}
              label="Cote de crédit"
              type="text"
              className={classes.textField}
              InputLabelProps={{
                shrink: true,
              }}
              margin="normal"
              variant="outlined"
            />
          </div>
        </form>

        <Button
          variant="contained"
          color="primary"
          className={classes.button}
          onClick={createLoanApplication}
        >
          Envoyer la demande
        </Button>
      </header>
    </div>
  );
}

export default LoanApplication;
