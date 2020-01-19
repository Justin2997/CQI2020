import React from 'react';
import logo from '../../assets/images/logo.png';
import './LoanApplicationHistory.css'
import { makeStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
//import Paper from '@material-ui/core/Paper';
import TablePagination from '@material-ui/core/TablePagination';
//import data from './dataResponse.js';

const axios = require('axios');


const columns = [
  { id: 'id', label: 'Id', maxWidth: 50 },
  { id: 'loan_term_in_years', label: 'Temps du Prêt', minWidth: 100 },
  {
    id: 'co_application_years_of_job_stability',
    label: 'Stabilité co-applicant',
    minWidth: 170,
    align: 'right',
    format: value => value.toLocaleString(),
  },
  {
    id: 'credit_rating',
    label: 'Note de crédit',
    minWidth: 170,
    align: 'right',
    format: value => value.toLocaleString(),
  },
  {
    id: 'years_of_job_stability',
    label: 'Stabilité de l\'applicant',
    minWidth: 170,
    align: 'right',
    format: value => value.toFixed(2),
  },
  {
    id: 'approved',
    label: 'Approbation',
    minWidth: 170,
    align: 'right',
    format: value => value.toLocaleString(),
  },
];

const useStyles = makeStyles({
  root: {
  width: '100%',
  },
  tableWrapper: {
    maxHeight: 440,
    overflow: 'auto',
  },
});

const data = axios.get('localhost:8000/profile/list').then(r => r.json());

function LoanApplicationHistory() {

  const classes = useStyles();
  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(10);

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = event => {
    setRowsPerPage(+event.target.value);
    setPage(0);
  };

  return (

    // <Paper className={classes.root}>
    <>
      <div className={classes.tableWrapper}>
        <Table stickyHeader aria-label="sticky table">
          <TableHead>
            <TableRow>
              {columns.map(column => (
                <TableCell
                  key={column.id}
                  align={column.align}
                  style={{ minWidth: column.minWidth }}
                >
                  {column.label}
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
          <TableBody>
          {data.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage).map(data => {
              return (
                <TableRow hover role="checkbox" tabIndex={-1} key={data.id}>
                  {columns.map(column => {
                    const value = data[column.id];
                    return (
                      <TableCell key={column.id} align={column.align}>
                        {column.format && typeof value === 'boolean' ? column.format(value) : value}
                      </TableCell>
                    );
                  })}
                </TableRow>
              );
            })}
          </TableBody>
        </Table>
      </div>
      <TablePagination
        rowsPerPageOptions={[10, 25, 100]}
        component="div"
        // count={rows.length}
        rowsPerPage={rowsPerPage}
        page={page}
        backIconButtonProps={{
          'aria-label': 'previous page',
        }}
        nextIconButtonProps={{
          'aria-label': 'next page',
        }}
        onChangePage={handleChangePage}
        onChangeRowsPerPage={handleChangeRowsPerPage}
      />
    </>
    // </Paper>
  );
}

export default LoanApplicationHistory;
