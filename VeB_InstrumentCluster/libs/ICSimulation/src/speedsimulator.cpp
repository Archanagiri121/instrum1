#include "include/speedsimulator.h"


SpeedSimulator::SpeedSimulator(QObject *parent)
    : QObject{parent},
    speed(0),
    distanceCovered(0),
    elapsedTime(0),
    totalDistance(2.0), //  total distance in KMs
    baseAccelRateMin(2.0),
    baseAccelRateMax(3.0),
    baseDecelRate(1.5),
    fluctuationRate(0.5),
    currentPhase(ACCEL_TO_60)
{
    calculateAdjustedRates();
    qDebug() << __FUNCTION__;
}


void SpeedSimulator::setTotalDistance(double distance) {
    qDebug() << "Simulation started.";
    totalDistance = distance;
    calculateAdjustedRates();
}

void SpeedSimulator::startSimulation() {
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &SpeedSimulator::updateSpeed);
    timer->start(static_cast<int>(dt * 1000)); // Convert dt to milliseconds
}

void SpeedSimulator::calculateAdjustedRates() {
    adjustedAccelRateMin = baseAccelRateMin * (baseDistance / totalDistance);
    adjustedAccelRateMax = baseAccelRateMax * (baseDistance / totalDistance);
    adjustedDecelRate = baseDecelRate * (baseDistance / totalDistance);
}

void SpeedSimulator::updateSpeed() {
    switch (currentPhase) {
    case ACCEL_TO_60:
        speed += adjustedAccelRateMin * dt;
        if (speed >= 60) {
            speed = 60;
            currentPhase = FLUCTUATE_50_60;
        }
        break;
    case FLUCTUATE_50_60:
        speed += ((std::rand() % 2 == 0) ? fluctuationRate : -fluctuationRate) * dt;
        if (speed < 50) speed = 50;
        if (speed > 60) speed = 60;
        // Transition condition based on time or distance can be added here
        if (distanceCovered >= totalDistance * 0.2) { // For example, move to next phase after covering 20% of the distance
            currentPhase = ACCEL_TO_120;
        }
        break;
    case ACCEL_TO_120:
        speed += adjustedAccelRateMax * dt;
        if (speed >= 120) {
            speed = 120;
            currentPhase = FLUCTUATE_120_130;
        }
        break;
    case FLUCTUATE_120_130:
        speed += ((std::rand() % 2 == 0) ? fluctuationRate : -fluctuationRate) * dt;
        if (speed < 120) speed = 120;
        if (speed > 130) speed = 130;
        // Transition condition based on time or distance can be added here
        if (distanceCovered >= totalDistance * 0.5) { // For example, move to next phase after covering 50% of the distance
            currentPhase = ACCEL_TO_150;
        }
        break;
    case ACCEL_TO_150:
        speed += adjustedAccelRateMax * dt;
        if (speed >= 150) {
            speed = 150;
            currentPhase = FLUCTUATE_140_150;
        }
        break;
    case FLUCTUATE_140_150:
        speed += ((std::rand() % 2 == 0) ? fluctuationRate : -fluctuationRate) * dt;
        if (speed < 140) speed = 140;
        if (speed > 150) speed = 150;
        // Transition condition based on time or distance can be added here
        if (distanceCovered >= totalDistance * 0.8) { // For example, move to next phase after covering 80% of the distance
            currentPhase = DECEL_TO_0;
        }
        break;
    case DECEL_TO_0:
        speed -= adjustedDecelRate * dt;
        if (speed <= 0) {
            speed = 0;
            emit simulationFinished();
            qDebug()<< "Simulation completed.";
        }
        break;
    }

    // Update distance and time
    distanceCovered += speed * dt / 3600.0; // Convert speed to km per second
    elapsedTime += dt;

    emit speedUpdated(speed);
    emit distanceUpdated(distanceCovered);

    // Check if total distance is covered
    if (distanceCovered >= totalDistance) {
        currentPhase = DECEL_TO_0;

    }
}
