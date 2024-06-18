import React from 'react';
import { Row, Col, Card, Table,  Form, Button } from 'react-bootstrap';
import { Link } from 'react-router-dom';



const dashSalesData = [
  { title: 'Daily Sales', amount: '$249.95', icon: 'icon-arrow-up text-c-green', value: 50, class: 'progress-c-theme' },
  { title: 'Monthly Sales', amount: '$2.942.32', icon: 'icon-arrow-down text-c-red', value: 36, class: 'progress-c-theme2' },
  { title: 'Yearly Sales', amount: '$8.638.32', icon: 'icon-arrow-up text-c-green', value: 70, color: 'progress-c-theme' }
];
// eslint-disable-next-line
const giltData = [
  { giltData: {id: '0', giltContract: '0x919A3b95Bd16d6AA0e89621c4491a463a8B6f3fc' , amount: '10000000000000000000',  erc20: { name: 'testGilt', symbol: 'tGilt', token: '0x847ed1C4d0141cEb2B559244EfADc7C885F44752'}, vault: '0x9F754733712331f4EB7aAb691EbBd66ec1b1c074', srcChainId: '421614', createDate: '1718355314', settled: 'false'}, giltWork: { wcontract: '0x919A3b95Bd16d6AA0e89621c4491a463a8B6f3fc',chainId: '421614', wid: '0'}},
  { giltData: {id: '1', giltContract: '0x919A3b95Bd16d6AA0e89621c4491a463a8B6f3fc' , amount: '10000000000000000000',  erc20: { name: 'testGilt', symbol: 'tGilt', token: '0x847ed1C4d0141cEb2B559244EfADc7C885F44752'}, vault: '0x9F754733712331f4EB7aAb691EbBd66ec1b1c074', srcChainId: '421614', createDate: '1718355314', settled: 'false'}, giltWork: { wcontract: '0x919A3b95Bd16d6AA0e89621c4491a463a8B6f3fc',chainId: '421614', wid: '1'}},
  { giltData: {id: '2', giltContract: '0x919A3b95Bd16d6AA0e89621c4491a463a8B6f3fc' , amount: '10000000000000000000',  erc20: { name: 'testGilt', symbol: 'tGilt', token: '0x847ed1C4d0141cEb2B559244EfADc7C885F44752'}, vault: '0x9F754733712331f4EB7aAb691EbBd66ec1b1c074', srcChainId: '421614', createDate: '1718355314', settled: 'false'}, giltWork: { wcontract: '0x919A3b95Bd16d6AA0e89621c4491a463a8B6f3fc',chainId: '421614', wid: '2'}}
];

function format( x ) {
  return x / 1e18;
}

function formatDate( x ) {
  return new Date(x*1000).toDateString();
}

const DashDefault = () => {
  return (
    <React.Fragment>
      <Row>
        {dashSalesData.map((data, index) => {
          return (
            <Col key={index} xl={6} xxl={4}>
              <Card>
                <Card.Body>
                  <h6 className="mb-4">{data.title}</h6>
                  <div className="row d-flex align-items-center">
                    <div className="col-9">
                      <h3 className="f-w-300 d-flex align-items-center m-b-0">
                        <i className={`feather ${data.icon} f-30 m-r-5`} /> $249.95
                      </h3>
                    </div>
                    <div className="col-3 text-end">
                      <p className="m-b-0">{data.value}%</p>
                    </div>
                  </div>
                  <div className="progress m-t-30" style={{ height: '7px' }}>
                    <div
                      className={`progress-bar ${data.class}`}
                      role="progressbar"
                      style={{ width: `${data.value}%` }}
                      aria-valuenow={data.value}
                      aria-valuemin="0"
                      aria-valuemax="100"
                    />
                  </div>
                </Card.Body>
              </Card>
            </Col>
          );
        })}

        <Col md={6} xl={8}>
          <Card className="Recent-Users">
            <Card.Header>
              <Card.Title as="h5">Your Crypto Gilts</Card.Title>
            </Card.Header>
            <Card.Body className="px-0 py-2">
              <Table responsive hover className="recent-users">
              <thead>
                    <td>Gilt Id</td>
                    <td>Amount</td>
                    <td>Create Date</td>
                    <td>Source Chain</td>
                    <td>Is Settled?</td>
                    <td></td>
                  </thead>
                <tbody>
                 
                {giltData.map((data, index) => {
                      return (
                  <tr key={index} className="unread">
                    <td>
                        {data.giltData.id} 
                    </td>
                    <td>
                      <h6 className="mb-1">{format(data.giltData.amount)}</h6>
                      <p className="m-0">{data.giltData.erc20.symbol}</p>
                    </td>
                    <td>
                      {formatDate(data.giltData.createDate)}
                    </td>
                    <td><h6 className="text-muted">{data.giltData.srcChainId}</h6></td>
                    <td><h6 className="text-muted">{data.giltData.settled}</h6></td>
                    <td>
                      <Link to="#" className="label theme-bg text-white f-12">
                        Settle
                      </Link>
                    </td>
                  </tr>
                     );
                    })}
                </tbody>
              </Table>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={4}>
          <Card className="card-event">
            <Card.Body>
              <h5>Create Gilt</h5>
            <Form.Group className="mb-3" controlId="exampleForm.ControlInput1">
                    <Form.Label>Gilt Amount</Form.Label>
                    <Form.Control type="text" placeholder="Text" />
                  </Form.Group>
                  <Form.Group className="mb-3" controlId="exampleForm.ControlSelect1">
                    <Form.Label>Select Currency</Form.Label>
                    <Form.Control as="select">
                      <option>USDC</option>
                      <option>DAI</option>
                      <option>SHIB</option>
                      <option>USDT</option>
                      <option>ETH</option>
                    </Form.Control>
                  </Form.Group>
                  <Button variant="secondary">Approve Gilt Contract</Button>
                  <Button variant="primary">Mint Gilt</Button>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={6}>
          <Card className="card-social">
            <Card.Body className="border-bottom">
            <h5>Teleport Gilt</h5>
            <Form.Group className="mb-3" controlId="exampleForm.ControlInput1">
                    <Form.Label>Gilt Id</Form.Label>
                    <Form.Control type="text" placeholder="Text" />
                  </Form.Group>
                  <Form.Group className="mb-3" controlId="exampleForm.ControlSelect1">
                    <Form.Label>Select Chain</Form.Label>
                    <Form.Control as="select">
                      <option>METER</option>
                      <option>AVALANCHE</option>
                      <option>BASE</option>
                      <option>OPTIMISM</option>
                      <option>WEMIX</option>
                    </Form.Control>
                  </Form.Group>
                  <Button variant="secondary">Approve Gilt Contract</Button>
                  <Button variant="primary">Teleport Gilt</Button>
            </Card.Body>
       
          </Card>
        </Col>
        <Col md={6} xl={6}>
          <Card className="card-social">
            <Card.Body className="border-bottom">
            <h5>Claim Gilt</h5>
            <Form.Group className="mb-3" controlId="exampleForm.ControlInput1">
                    <Form.Label>Gilt Id</Form.Label>
                    <Form.Control type="text" placeholder="Text" />
                  </Form.Group>
                  <Form.Group className="mb-3" controlId="exampleForm.ControlSelect1">
                    <Form.Label>Select Chain</Form.Label>
                    <Form.Control as="select">
                      <option>METER</option>
                      <option>AVALANCHE</option>
                      <option>BASE</option>
                      <option>OPTIMISM</option>
                      <option>WEMIX</option>
                    </Form.Control>
                  </Form.Group>
                  <Button variant="primary">Claim Gilt</Button>
            </Card.Body>
       
          </Card>
        </Col>
      </Row>
    </React.Fragment>
  );
};

export default DashDefault;
