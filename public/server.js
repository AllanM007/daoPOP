require("dotenv").config();
const express = require("express");
const app = express();
const url = require('url');
const path = require("path");
const axios = require("axios");
const bodyParser = require("body-parser");

const router = express.Router();

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

const API_KEY = process.env.ALCHEMY_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;


// const { json } = require("hardhat/internal/core/par
const { ethers } = require("ethers");
// const tokenABI = require("../artifacts/contracts/ERC20.sol/ERC20.json");

// Provider
const alchemyProvider = new ethers.providers.AlchemyProvider(
  (network = "goerli"),
  API_KEY
);

// Signer
const signer = new ethers.Wallet(PRIVATE_KEY, alchemyProvider);

// gas limit
const gas_limit = "0x100000";

// Token Contract
const dPOPTokenContract = new ethers.Contract(
  dPOPTokenAddress,
  tokenABI.abi,
  signer
);

router.get("/", function (req, res) {
  res.sendFile(path.join(__dirname + "/index.html"));
  //__dirname : It will resolve to your project folder.
});

router.get("/propose", function (req, res) {
  res.sendFile(path.join(__dirname + "/propose.html"));
  //__dirname : It will resolve to your project folder.
});

router.get("/vote", function (req, res) {
  res.sendFile(path.join(__dirname + "/vote.html"));
  //__dirname : It will resolve to your project folder.
});

router.get("/transfer", function (req, res) {
  res.sendFile(path.join(__dirname + "/transfer.html"));
});

router.get("/mint", function (req, res) {
  res.sendFile(path.join(__dirname + "/mint.html"));
});

router.get("/burn", function (req, res) {
  res.sendFile(path.join(__dirname + "/burn.html"));
});

router.get("/community", function (req, res) {
  res.sendFile(path.join(__dirname + "/community_dashboard.html"));
});

router.get("/personal", function (req, res) {
  res.sendFile(path.join(__dirname + "/personal_dashboard.html"));
});

router.post("/sendProposal", function (req, res) {
  var data = req.body;
  console.log(data);

  var usrAddress = data.address;
  var name = data.name;
  var date = Date.now();
  var deadline = Date.now();

  console.log("71.", usrAddress, name, date, deadline);

  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(sendProposal(usrAddress, name, date, deadline));
    }, 2000);
  });
});

async function sendProposal(usrAddress, name, date, deadline) {
  const gasPrice = await alchemyProvider.getGasPrice();

  const formattedGasPrice = gasPrice.toString();

  console.log(formattedGasPrice);

  try {
    const sendProposaltx = await governanceContract
      .connect(signer)
      .propose(usrAddress, name, date, deadline, {
        gasLimit: 50000,
      });

    console.log(sendProposaltx);

    const sendProposalObject = await sendProposaltx.wait();

    console.log(sendProposalObject);

    const proposalObject = sendProposalObject.events.find(
      (event) => event.event === "ProposalCreated"
    );

    const [to, value] = proposalObject.args;

    console.log(to, value.toString());
  } catch (error) {
    console.log(error);
  }
}

router.get("/getVaultBalance", async function (req, res) {
  const vault = await collateralAdapterContract.Vault(
    "0x15cdCBB08cd5b2543A8E009Dbf5a6C6d7D2aB53d"
  );

  const fmtVaultBalance = vault.toString() / 10 ** 6;
  var context = {
    vaultAmount: fmtVaultBalance,
  };
  console.log("Vault Balance:", fmtVaultBalance);

  res.json(context);
});

router.get("/getAccountdPOPBalance", async function (req, res) {
  const dpopBalance = await dPOPTokenContract.balanceOf(
    "0x15cdCBB08cd5b2543A8E009Dbf5a6C6d7D2aB53d"
  );

  const fmtDPOPBalance = dpopBalance.toString();

  var context = {
    dPOPAmount: fmtDPOPBalance,
  };
  console.log("Vault Balance:", fmtDPOPBalance);

  res.json(context);
});

router.post("/mintdPOP", function (req, res) {
  var data = req.body;
  console.log(data);

  var usrAddress = data.address;
  var amount = data.amount;

  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(mintdPOP(usrAddress, amount));
    }, 2000);
  });
});

async function calculatePositionHealthFactor(usrAddress) {

  const collateralPrice = await oracleContract.price();

  try {
    const calculateHealthFactortx = await collateralAdapterContract
      .connect(signer)
      .calculateHealthFactor(usrAddress, collateralPrice, { gasLimit: 1000000 });

    console.log(calculateHealthFactortx);

    const calculateHealthFactortxObject = await calculateHealthFactortx.wait();

    console.log(calculateHealthFactortxObject);

    return "Calculation Succesful";
  } catch (error) {
    console.log(error);

    return error;
  }
}

async function mintdPOP(usrAddress, mintAmount) {
  const gasPrice = await alchemyProvider.getGasPrice();

  const formattedGasPrice = gasPrice.toString();

  console.log(formattedGasPrice);

  try {
    const mintdPOPtx = await collateralAdapterContract
      .connect(signer)
      .initiateMint(usrAddress, mintAmount, { gasLimit: 1000000 });

    console.log(mintdPOPtx);

    const mintdPOPObject = await mintdPOPtx.wait();

    console.log(mintdPOPObject);

    const mintObject = mintdPOPObject.events.find(
      (event) => event.event === "Mint"
    );

    const [to, value] = mintObject.args;

    console.log(to, value.toString());

    // calculatePositionHealthFactor(usrAddress);
    res.jsonp({success : true})
  } catch (error) {
    console.log(error);

    return error;
  }
}

router.post("/transferdPOP", function (req, res) {
  var data = req.body;
  console.log(data);

  var usrAddress = data.address;
  var amount = data.amount;

  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(transferdPOP(usrAddress, amount));
    }, 2000);
  });
});

async function transferdPOP(usrAddress, burnAmount) {
  const gasPrice = await alchemyProvider.getGasPrice();

  const formattedGasPrice = gasPrice.toString();

  console.log(formattedGasPrice);

  try {
    // const bKESTransferApproval = await bKESTokenContract.approve(
    //   usrAddress,
    //   burnAmount
    // );

    // const approvalConfirmation = bKESTransferApproval.wait();

    if (1 == 1) {
      const dPOPTransfer = await dPOPTokenContract.transferFrom(
        usrAddress,
        dPOPTokenAddress,
        burnAmount
      );

      const dPOPTransferTx = await dPOPTransfer.wait();

      console.log(dPOPTransferTx);

    } else {
    }
  } catch (error) {
    console.log(error);

    return error;
  }
}

router.get("/getProposals", async function (req, res) {
  proposals = []

  const proposalsCount = await governanceContract.proposalCount();

  for (let item = 0; item < proposalsCount; item++) {
    const activeproposals = await collateralAdapterContract.getPositionHealthFactor(item, { gasLimit: 1000000 });

    var proposalsToString = activeproposals.toString();

    var fmtProposals = proposalsToString.split(',');

    const proposalsMap = [];
    const keyArray = ["id", "usrAddress", "debt", "dcr"];

    fmtProposals.map(function (value, index) {
      proposalsMap.push(value)
    })

    const proposalsArray = Object.assign.apply({}, keyArray.map( (v, i) => ( {[v]: fmtProposals[i]} ) ) );

    proposals.push(proposalsArray);

  }

  var context = {
    data: positions,
  };

  res.json(context);
});

//add the router
app.use("/", router);
app.listen(process.env.port || 3000);
app.use(express.static(path.join(__dirname, "public")));
app.use("/js", express.static(__dirname + "/js"));

console.log("Running at Port 3000");