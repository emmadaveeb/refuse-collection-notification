const AWS = require('aws-sdk');
const axios = require('axios');
const add = require('date-fns/add');

exports.handler = async () => {
    const { locationApi, postCode, doorNumber, collectionApi, phoneNumber } = process.env;
    const { data } = await axios.get(`${locationApi}${postCode}`);
    const addresses = data.data;
    const location = addresses.find(item => item[2].includes(doorNumber));
    const tomorrow = add(new Date(), { days: 1 }).toISOString().slice(5,10);

    if(!location) throw new Error('Location not found.');

    const locationId = location[0];
    const { data: collectionResponse } = await axios.get(`${collectionApi}${locationId}`);
    const collectionDates = collectionResponse.Results.Refuse_collection_dates;

    const nextRecyclingCollection = new Date(collectionDates.find(item => item['_'].includes('Dry Recycling')).Next_Collection).toISOString().slice(5,10);
    const nextRefuseCollection = new Date(collectionDates.find(item => item['_'].includes('Refuse Collection')).Next_Collection).toISOString().slice(5,10);

    let Message = '';
    tomorrow === nextRecyclingCollection ? Message += 'Your dry recycling is being collected tomorrow.' : null;
    tomorrow === nextRefuseCollection ? 
        (Message ? Message += ' Your refuse collection day is tomorrow.' : Message += 'Your refuse collection day is tomorrow.') : null;

    if(Message) {
        const sns = new AWS.SNS();
        const parameters = {
            Message,
            PhoneNumber: phoneNumber
        }
        console.log('Sending notification message', { parameters });
        await sns.publish(parameters).promise();
    }

    return;
}