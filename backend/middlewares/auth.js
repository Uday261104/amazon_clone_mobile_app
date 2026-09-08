const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {
    const token = req.header('token');

    if (!token) {
        return res.status(401).json({
            msg: "No validation token"
        });
    }

    try {
        const verify = jwt.verify(token, "sercretKey");

        req.user = verify;
        req.token = token;

        next();

    } catch (error) {
        return res.status(401).json({
            msg: "Unauthorized"
        });
    }
};

module.exports = auth;