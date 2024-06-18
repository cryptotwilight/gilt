import React from 'react';
import {  Button } from 'react-bootstrap';


import useWindowSize from '../../../../hooks/useWindowSize';

const NavLeft = () => {
  const windowSize = useWindowSize();

  if (windowSize.width <= 575) {
    navItemClass = [...navItemClass, 'd-none'];
  }

  return (
    <React.Fragment>
      <p><Button variant="secondary"> Connect Web3 </Button></p>
    </React.Fragment>
  );
};

export default NavLeft;
